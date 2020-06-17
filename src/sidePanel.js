import initState, { context, Menus, IdentifierPrefix, SidePanelIdentifier } from './state'
import { Browser, BrowserManage } from './webview/index'
import { createImageView, addButton, createBoxSeparator, observerWindowResizeNotification, removeObserverWindowResizeNotification, setSettingForKey, removeSettingForKey } from './utils'

import sketch from 'sketch'
import {Style} from 'sketch/dom'

/**
 * insertSidePanel 插入侧边栏
 * @param {*} toolbar
 * @param {*} identifier
 * @param {*} isInsert  默认插入，已插入删除
 */
const insertSidePanel = (toolbar, identifier, isInsert = false) => {
  const contentView = context.document.documentWindow().contentView()
  const stageView = contentView.subviews().objectAtIndex(0)

  const views = stageView.subviews()
  const existId = isInsert || views.find(d => ''.concat(d.identifier()) === identifier)
  console.log('views', views);
  console.log('existId', existId);

  const finalViews = []
  let pushedWebView = false

  for (let i = 0; i < views.count(); i++) {
    const view = views[i]
    if (existId) {
        console.log('==>', i, view.identifier(), identifier);
      if (''.concat(view.identifier()) !== identifier) finalViews.push(view)
    } else {
      finalViews.push(view)
      if (!pushedWebView && ''.concat(view.identifier()) === 'view_canvas') {
        finalViews.push(toolbar)
        pushedWebView = true
      }
    }
  }
  console.log('pushedWebView', pushedWebView);
  console.log('finalViews', finalViews);

  if (pushedWebView) {
    setSettingForKey(SidePanelIdentifier, 'true')
  } else {
    removeSettingForKey(SidePanelIdentifier)
  }


  stageView.subviews = finalViews
  stageView.adjustSubviews()
}

let activeWebView
export const onToggleSidePanel = context => {
  console.error('✅✅ 展示 plugins')
  // register context
  initState(context)

  const threadDictionary = NSThread.mainThread().threadDictionary()
  if (threadDictionary[SidePanelIdentifier]) {
    insertSidePanel(threadDictionary[SidePanelIdentifier], SidePanelIdentifier, true)
    onShutdown()
    return
  }

  // Long-running script
  COScript.currentCOScript().setShouldKeepAround(true)

  observerWindowResizeNotification(() => {
    const curWebView = BrowserManage.getCurrent()
    if (curWebView) {
      curWebView.updatePosition()
    }
  })

  const toolbar = NSStackView.alloc().initWithFrame(NSMakeRect(0, 0, 40, 400))
  threadDictionary[SidePanelIdentifier] = toolbar
  toolbar.identifier = SidePanelIdentifier
  toolbar.setSpacing(8)
  toolbar.setFlipped(true)
  toolbar.setBackgroundColor(NSColor.windowBackgroundColor())

  toolbar.orientation = 1


  toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 22), 'transparent', NSMakeSize(40, 22)), 1)
  const Logo = createImageView(NSMakeRect(0, 0, 40, 30), 'logo', NSMakeSize(40, 28))
  toolbar.addSubview(Logo)

  Menus.map((item, index) => {
    const {
      rect = NSMakeRect(0, 0, 40, 40),
      size = NSMakeSize(24, 24),
      icon,
      activeIcon,
      tooltip,
      identifier,
      wkIdentifier,
      type = 2,
      inGravityType = 1,
      url,
      height,
      width,
      resizable
    } = item

    const Button = addButton({
      rect,
      size,
      icon,
      activeIcon,
      tooltip,
      identifier,
      type,
      callAction: sender => {
        // log('sender', sender)
        const threadDictionary = NSThread.mainThread().threadDictionary()
        const menuBtnRegExp = new RegExp(`${IdentifierPrefix}-menu*`)
        for (const k in threadDictionary) {
          if (menuBtnRegExp.test(k) && k !== identifier) {
            threadDictionary[k].setState(NSOffState)
          }
        }
        console.log('init webview', index);
        const options = {
          resizable: false,
          sender,
          identifier: wkIdentifier,
          frame: false,
          show: false,
          width: width || 320,
          height: height || 480,
          inGravityType,
          url,
          useContentSize: true
        }

        const { browserWindow } = new Browser(options)

        const webView = browserWindow.webContents
        activeWebView = webView
        webView.on('ColorSelected', function(options) {

          const doc = sketch.getSelectedDocument()
          const selectedLayers = doc.selectedLayers
          selectedLayers.forEach((layer) => {
            // if (layer.type === "Text") {
              layer.style.fills=[{
                color: options.hex,
                fillType: Style.FillType.Color,
              }] ;
            // }
          });

          // console.log('ColorSelected', JSON.stringify(options));
          // sketch.UI.message(`Color Selected ${JSON.stringify(options)}`);
        });


        let cc;
        const doc = sketch.getSelectedDocument()
        const selectedLayers = doc.selectedLayers
        selectedLayers.forEach((layer) => {
          if (layer.style && layer.style.fills && layer.style.fills[0] &&  layer.style.fills[0].color) {
            cc = layer.style.fills[0].color;
            // sketch.UI.message(`Layers color: ${cc}`)
          }
        });
        // console.log(cc, 22 ,`applyColor("${cc}");`)
        webView.executeJavaScript(`applyColor("${cc}");`)
        .then(res => {
          // do something with the result
        });

        webView.on('did-start-loading', () => {
          // console.error('did-start-loading')
        })

        webView.on('did-finish-load', () => {
          // console.error('did-finish-load')
        })

        webView.on('openView', options => {

        })
      }
    })

    threadDictionary[identifier] = Button

    toolbar.addView_inGravity(createBoxSeparator(), inGravityType)
    toolbar.addView_inGravity(Button, inGravityType)

    if (icon === 'fill') toolbar.addView_inGravity(createBoxSeparator(), inGravityType)
    if (index === Menus.length - 1) toolbar.addView_inGravity(createImageView(NSMakeRect(0, 0, 40, 8), 'transparent'), 3)
  })

  insertSidePanel(toolbar, SidePanelIdentifier)
}


export const onOpenDocument = () => {}

export const onCloseDocument = context => {
  initState(context)
  onShutdown()
}

// handler cleanly Long-running script
export function onShutdown () {
  // console.error('✅✅ my-plugins onShutdown')
  const threadDictionary = NSThread.mainThread().threadDictionary()
  BrowserManage.empty()
  const prefixRegExp = new RegExp(`${IdentifierPrefix}*`)
  const webViewPrefixRegExp = new RegExp(`${IdentifierPrefix}-webview*`)

  // clear MSClass
  for (const key in threadDictionary) {
    if (prefixRegExp.test(key)) {
      if (webViewPrefixRegExp.test(key)) {
        threadDictionary[key].close()
      }
      threadDictionary.removeObjectForKey(key)
    }
  }

  // clear WindowResizeNotification
  removeObserverWindowResizeNotification()

  COScript.currentCOScript().setShouldKeepAround(false)
}


export const onSelectionChanged = () => {
  // console.log(activeWebView);
  // const doc = sketch.getSelectedDocument()
  // const selectedLayers = doc.selectedLayers
  // selectedLayers.forEach((layer) => {
  //   if (layer.style && layer.style.fills && layer.style.fills[0] &&  layer.style.fills[0].color) {
  //     cc = layer.style.fills[0].color;
  //     console.log(cc);
  //     // sketch.UI.message(`Layers color: ${cc}`)
  //   }
  // });

}
