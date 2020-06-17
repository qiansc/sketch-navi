import { SketchContext } from './core/sketch-context';
import { PanelFactory } from './core/panel-factory';
import { Panel } from './core/panel';

export function onToggle(context: any) {

    const sketchContext = SketchContext.getOrCreate(context);

    const panelFactory = new PanelFactory(sketchContext.documentID);

    panelFactory.regist('navi', Panel);

    let panel = panelFactory.hasPanel(Panel);

    if (panel){
        insertSidePanel(context, panel.view, panel.id, true);
        onShutdown(sketchContext.documentID, panelFactory.getIDPrefix('navi'));
        return;
    }

    COScript.currentCOScript().setShouldKeepAround(true);
    panel = panelFactory.createPanel(Panel);

    insertSidePanel(context, panel.view, panel.id);
}



/**
 * insertSidePanel 插入侧边栏
 * @param {*} toolbar
 * @param {*} identifier
 * @param {*} isInsert  默认插入，已插入删除
 */
const insertSidePanel = (context: any, toolbar: any, identifier: string, isInsert: boolean = false) => {
    const contentView = context.document.documentWindow().contentView()
    const stageView = contentView.subviews().objectAtIndex(0)

    const views = stageView.subviews()

    const existId = isInsert || views.find((d: any) => ''.concat(d.identifier()) === identifier)

    const finalViews = []
    let pushedWebView = false

    for (let i = 0; i < views.count(); i++) {
      const view = views[i]
      if (existId) {
        if (''.concat(view.identifier()) !== identifier) finalViews.push(view)
      } else {
        finalViews.push(view)
        if (!pushedWebView && ''.concat(view.identifier()) === 'view_canvas') {
          finalViews.push(toolbar)
          pushedWebView = true
        }
      }
    }

    if (pushedWebView) {
      setSettingForKey(identifier, 'true')
    } else {
      removeSettingForKey(identifier)
    }


    stageView.subviews = finalViews
    stageView.adjustSubviews()
}




/**
 * setSettingForKey 挂载到 NSUserDefaults 的键值
 * @param {string} key
 * @param {string} value
 */
export const setSettingForKey = (key: string, value: string) => NSUserDefaults.standardUserDefaults().setObject_forKey(value, key)

/**
 * removeSettingForKey 移除挂载到 NSUserDefaults 的键值
 * @param { string } key
 */
export const removeSettingForKey = (key: any) => {
  setSettingForKey(key, nil)
}

/**
 * getThreadDictForKey 获取挂载 mainThread 的键值
 * @param {string} key
 */
export const getThreadDictForKey = (key: any) => NSThread.mainThread().threadDictionary()[key]

/**
 * removeObserverWindowResizeNotification 清除监听窗口resize
 * @param {*} fn
 */
export const removeObserverWindowResizeNotification = (documentObjectID: any) => {
    const delegateInstance = getThreadDictForKey(`window-move-instance-${documentObjectID}`)
    if (delegateInstance) {
      NSNotificationCenter.defaultCenter().removeObserver_name_object(delegateInstance, NSWindowDidResizeNotification, nil)
      removeThreadDictForKey(`window-move-instance-${documentObjectID}`)
      removeThreadDictForKey(`window-move-selector-${documentObjectID}`)
    }
  }

/**
 * removeThreadDictForKey 移除挂载到 mainThread 的键值
 * @param { string } key
 */
export const removeThreadDictForKey = (key: any) => {
    if (NSThread.mainThread().threadDictionary()[key]) NSThread.mainThread().threadDictionary().removeObjectForKey(key)
  }



// handler cleanly Long-running script
export function onShutdown (documentObjectID: string, IdentifierPrefix: string) {
    const threadDictionary = NSThread.mainThread().threadDictionary()
    //  BrowserManage.empty()

    const prefixRegExp = new RegExp(`${IdentifierPrefix}*`)
    const webViewPrefixRegExp = new RegExp(`${IdentifierPrefix}-webview*`)

    for (const key in threadDictionary) {
      if (prefixRegExp.test(key)) {
        if (webViewPrefixRegExp.test(key)) {
          threadDictionary[key].close()
        }
        threadDictionary.removeObjectForKey(key)
      }
    }

    // clear WindowResizeNotification
    removeObserverWindowResizeNotification(documentObjectID)

    COScript.currentCOScript().setShouldKeepAround(false)
  }
