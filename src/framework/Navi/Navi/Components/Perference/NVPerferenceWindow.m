//
//  NVPerferenceWindow.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPerferenceWindow.h"
#import "NVPerference.h"
#import "NVBundle.h"

@implementation NVPerferenceWindow

+ (instancetype)initFromNIB{
    NVPerference *xib = [[NVPerference alloc] initWithNibName:@"NVPerference" bundle: [NVBundle bundlePath]];
    NSRect xframe = xib.view.frame;
    
    
    NSRect frame = NSMakeRect(100, 400, xframe.size.width, xframe.size.height);
    NSRect rect = [NSWindow contentRectForFrameRect:frame styleMask:NSWindowStyleMaskBorderless];
    NSWindowStyleMask mask =  NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskFullSizeContentView;
    NVPerferenceWindow *window = [[NVPerferenceWindow alloc] initWithContentRect:rect styleMask:mask backing:NSBackingStoreBuffered defer:false];
    window.titleVisibility = NSWindowTitleVisible;
    window.titlebarAppearsTransparent = YES;
    [window setTitle:@""];
    [window setLevel:CGWindowLevelForKey(kCGMaximumWindowLevelKey)];
    [window center];
    [window makeKeyAndOrderFront:window];
    window.delegate = window;
    xib.window = window;
    window.contentView= xib.view;
    return window;
}

- (BOOL)windowShouldClose:(NSWindow *)sender{
    [self setIsVisible:NO];
    return NO;
}

- (void)windowWillClose:(NSNotification *)notification{
    // [NSApp stopModal];
}

- (void)toogle {
    [self setIsVisible:!self.isVisible];
}

@end
