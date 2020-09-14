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

export const createImage = (imageURL: string, size?: number) => {
    // NSImage.alloc().initWithSize([width, height])
    const Image = NSImage.alloc().initWithContentsOfURL(imageURL);
    // size && Image.setSize(size)
    Image.setScalesWhenResized(true)
    return Image
 }
