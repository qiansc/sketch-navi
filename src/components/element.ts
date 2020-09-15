interface ButtonOptions {
    rect?: any,
    size: number,
    iconUrl: string,
    activeIconUrl?: string,
    tooltip?: string,
    type?: number,
    callAction?: any
}

/** 创建 NSButton */
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


/** 创建 NSImageView */
export const createImageView = (rect: any, imageURL: any, size?: any) => {
    const imageView = NSImageView.alloc().initWithFrame(rect)
    const image = createImage(imageURL, size)
    imageView.setImage(image)
    imageView.setAutoresizingMask(5)
    return imageView
}

/** 创建 NSImage */
export const createImage = (imageURL: string, size?: number) => {
    // NSImage.alloc().initWithSize([width, height])
    const Image = NSImage.alloc().initWithContentsOfURL(imageURL)
    size && Image.setSize(size)
    Image.setScalesWhenResized(true)
    return Image
 }

 /** 创建 NSBoxSeparator */
export function createBoxSeparator() {
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
