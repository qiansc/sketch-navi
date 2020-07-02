/** 一些常用NativeView的创建方法 */

import { SketchContext } from "./sketch-context";


export const getImageURL = (name: string, context: SketchContext) => {
    const isRetinaDisplay = NSScreen.mainScreen().backingScaleFactor() > 1
    const suffix = isRetinaDisplay ? '@2x' : ''
    const pluginSketch = context.plugin.url();
    const imageURL = pluginSketch
      .URLByAppendingPathComponent('Contents')
      .URLByAppendingPathComponent('Resources')
      .URLByAppendingPathComponent('icons')
      .URLByAppendingPathComponent(`${name + suffix}.png`)
    return imageURL
  }


  export const createImage = (imageURL: string, size: number) => {
    // NSImage.alloc().initWithSize([width, height])
    const Image = NSImage.alloc().initWithContentsOfURL(imageURL)
    size && Image.setSize(size)
    Image.setScalesWhenResized(true)
    return Image
  }


  export const createImageView = (rect: any, imageURL: string, size: number) => {
    const imageView = NSImageView.alloc().initWithFrame(rect)
    const image = createImage(imageURL, size)
    imageView.setImage(image)
    imageView.setAutoresizingMask(5)
    return imageView
  }

  export const createBoxSeparator = () => {
    // set to 0 in width and height
    const separtorBox = NSBox.alloc().initWithFrame(NSZeroRect)
    // Specifies that the box is a separator
    separtorBox.setBoxType(2 || NSBoxSeparator)
    separtorBox.setBorderColor(NSColor.colorWithHex('#F5F5F5'))
    try {
      separtorBox.setBorderColor(NSColor.colorWithSRGBRed_green_blue_alpha(1.0, 1.0, 1.0, 1.0))
    } catch (error) {
      console.error(error)
    }

    // separtorBox.setTransparent(true)
    return separtorBox
  }

  interface ButtonOptions {
    rect?: any,
    size: number,
    iconUrl: string,
    activeIconUrl?: string,
    tooltip?: string,
    type?: number,
    callAction?: any
  }

  export const createButton = ({ rect, size, iconUrl, activeIconUrl, tooltip = '', type = 5, callAction }: ButtonOptions) => {
    const button = rect ? NSButton.alloc().initWithFrame(rect) : NSButton.alloc().init()
    const image = createImage(iconUrl, size)
    button.setImage(image)

    if (activeIconUrl) {
      const activeImage = createImage(activeIconUrl, size)
      button.setAlternateImage(activeImage)
    } else {
      button.setAlternateImage(image)
    }
    button.setBordered(false)
    button.sizeToFit()
    button.setToolTip(tooltip)
    button.setButtonType(type || NSMomentaryChangeButton)
    button.setCOSJSTargetFunction(callAction)
    button.setAction('callAction:')
    button.removeBadge = () => {
      button.setImage(image)
      button.hasBadge = false
    }
    button.icon = iconUrl;
    return button
  }

  interface TextButtonOptions {
    rect?: any,
    textFiled: TextField,
    iconUrl?: string,
    tooltip?: string,
    type?: number,
    callAction?: any
  }


  export const createTextButton = ({ rect, textFiled, tooltip = '', type = 5, callAction }: TextButtonOptions) => {
    const button = rect ? NSButton.alloc().initWithFrame(rect) : NSButton.alloc().init()
    button.textFiled = textFiled;
    button.setBordered(false)
    button.sizeToFit()
    button.setToolTip(tooltip)
    button.setButtonType(type || NSMomentaryChangeButton)
    button.setCOSJSTargetFunction(callAction)
    button.setAction('callAction:')
    button.removeBadge = () => {
      // button.setImage(image)
      button.hasBadge = false
    }
    return button
  }


  export const createBounds = (x = 0, y = 0, width = 0, height = 0) => NSMakeRect(
    x,
    y,
    width,
    height
  )

  export const createPanel = (options = {
    width: 800,
    height: 600,
    minWidth: 0,
    minHeight: 0,
    x: 0,
    y: 0,
    title: 'panel',
    identifier: 'sketch-panel',
    vibrancy: true,
  }) => {
    COScript.currentCOScript().setShouldKeepAround(true)

    const threadDictionary = NSThread.mainThread().threadDictionary()
    const mainScreenRect = NSScreen.screens()
      .firstObject()
      .frame()

    const Bounds = NSMakeRect(
      options.x ? options.x : Math.round((NSWidth(mainScreenRect) - options.width) / 2),
      options.y ? NSHeight(mainScreenRect) - options.y : Math.round((NSHeight(mainScreenRect) - options.height) / 2),
      options.width,
      options.height
    )
    const panel = NSPanel.alloc().init()
    panel.setFrame_display(Bounds, true)
    panel.setOpaque(0)
    threadDictionary[options.identifier] = panel

    // NSWindowStyleMaskDocModalWindow 直角
    panel.setStyleMask(NSWindowStyleMaskFullSizeContentView | NSBorderlessWindowMask | NSResizableWindowMask | NSTexturedBackgroundWindowMask | NSTitledWindowMask | NSClosableWindowMask | NSFullSizeContentViewWindowMask | NSWindowStyleMaskResizable)
    panel.setBackgroundColor(NSColor.whiteColor() || NSColor.windowBackgroundColor())

    panel.title = options.title
    panel.movableByWindowBackground = true
    panel.titlebarAppearsTransparent = true
    panel.titleVisibility = NSWindowTitleHidden

    panel.center()
    panel.makeKeyAndOrderFront(null)
    panel.setLevel(NSFloatingWindowLevel)
    panel.minSize = NSMakeSize(options.minWidth, options.minHeight)

    panel.standardWindowButton(NSWindowZoomButton).setHidden(true)
    panel.standardWindowButton(NSWindowMiniaturizeButton).setHidden(true)
    panel.standardWindowButton(NSWindowCloseButton).setHidden(true)

    // Some third-party macOS utilities check the zoom button's enabled state to
    // determine whether to show custom UI on hover, so we disable it here to
    // prevent them from doing so in a frameless app window.
    panel.standardWindowButton(NSWindowZoomButton).setEnabled(false)

    // The fullscreen button should always be hidden for frameless window.
    if (panel.standardWindowButton(NSWindowFullScreenButton)) {
      panel.standardWindowButton(NSWindowFullScreenButton).setHidden(true)
    }

    panel.showsToolbarButton = false
    panel.movableByWindowBackground = true

    if (options.vibrancy) {
      // Create the blurred background
      const effectView = NSVisualEffectView.alloc().initWithFrame(NSMakeRect(0, 0, options.width, options.height))
      effectView.setMaterial(NSVisualEffectMaterialPopover)
      effectView.setAutoresizingMask(NSViewWidthSizable | NSViewHeightSizable)
      effectView.setAppearance(NSAppearance.appearanceNamed(NSAppearanceNameVibrantLight))
      effectView.setBlendingMode(NSVisualEffectBlendingModeBehindWindow)

      // Add it to the panel
      panel.contentView().addSubview(effectView)
    }

    const closeButton = panel.standardWindowButton(NSWindowCloseButton)
    closeButton.setCOSJSTargetFunction((sender: any) => {
      console.log(sender)

      panel.close()

      // Remove the reference to the panel
      threadDictionary.removeObjectForKey(options.identifier)

      // Stop this Long-running script
      COScript.currentCOScript().setShouldKeepAround(false)
    })
    return panel
  }

  export const createView = (frame: any) => {
    const view = NSView.alloc().initWithFrame(frame)
    view.setFlipped(1)
    return view
  }

  export const createBox = (frame: any) => {
    const box = NSBox.alloc().initWithFrame(frame)
    box.setTitle('')
    return box
  }

  export const createTextField = (string: string, frame: any) => {
    const field: TextField = NSTextField.alloc().initWithFrame(frame)

    field.setStringValue(string)
    field.setFont(NSFont.systemFontOfSize(12))
    field.setTextColor(
      NSColor.colorWithCalibratedRed_green_blue_alpha(0, 0, 0, 0.7)
    )
    field.setBezeled(0)
    field.setBackgroundColor(NSColor.windowBackgroundColor())
    field.setEditable(0)

    return field
  }

