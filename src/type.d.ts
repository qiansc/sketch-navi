interface Url {
    URLByAppendingPathComponent: (path: String) => Url
}

interface Color {

}


interface Plugin {
    url: () => Url
}

interface TextField {
    setStringValue: (value: String) => void
    setFont: (number: Number) => void
    setBezeled: (number: Number) => void
    setBackgroundColor: (color: any) => void
    setTextColor: (color: any) => void
    setEditable: (enabled: number) => void
}

declare var NSThread: any;
declare var MSDocument: any;
declare var NSStackView: any;
declare var NSTabView: any;
declare var NSMakeRect: any;
declare var NSColor: any;
declare var NSUserDefaults: any;
declare var nil: any;
declare var COScript: any;
// declare var BrowserManage: any;
declare var NSNotificationCenter: any;
declare var NSWindowDidResizeNotification: any;
declare var NSScreen: any;
declare var NSImage: any;
declare var NSImageView: any;
declare var NSBox: any;
declare var NSZeroRect: any;
declare var NSBoxSeparator: any;
declare var NSColor: any;
declare var NSButton: any;
declare var NSMomentaryChangeButton: any;
declare var NSWidth: any;
declare var NSHeight: any;
declare var NSPanel: any;
declare var NSWindowStyleMaskFullSizeContentView: any;
declare var NSTextField: any;
declare var NSFont: any;
declare var NSView: any;
declare var NSMakeSize: any;
declare var NSVisualEffectView: any;
declare var NSVisualEffectMaterialPopover: any;
declare var NSViewWidthSizable: any;
declare var NSViewHeightSizable: any;
declare var NSAppearance: any;
declare var NSAppearanceNameVibrantLight: any;
declare var NSVisualEffectBlendingModeBehindWindow: any;
declare var NSWindowCloseButton: any;
declare var NSFloatingWindowLevel: any;
declare var NSWindowZoomButton: any;
declare var NSWindowFullScreenButton: any;
declare var NSWindowTitleHidden: any;
declare var NSBorderlessWindowMask: any;
declare var NSResizableWindowMask: any;
declare var NSTexturedBackgroundWindowMask: any;
declare var NSTitledWindowMask: any;
declare var NSClosableWindowMask: any;
declare var NSFullSizeContentViewWindowMask: any;
declare var NSWindowStyleMaskResizable: any;
declare var NSWindowStyleMaskTitled: any;
declare var NSWindowStyleMaskClosable: any;
declare var NSWindowMiniaturizeButton: any;
declare var NSBackingStoreBuffered: any;
declare var NSWindowTitleVisible: any;
declare var NSSwitchButton: any;
declare var NSOnState: any;
declare var NSButtonCell: any;
declare var NSRadioButton: any;
declare var NSWindowStyleMaskBorderless: any;
declare var NSWindow: any;
declare var NSApp: any;
declare var NSBundle: any;
declare var NSURL: any;


declare var EventEmitter: any;
declare var __command: any;
declare var NSJSONSerialization: any;


