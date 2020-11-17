//
//  NVDocument.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVDocument.h"

@implementation NVDocument {
    NSLayoutConstraint *constraint;
    NSWindow *window;
    BOOL windowMod;
}

- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _minWidth = 40;
        _maxWidth = 40;
        self.menuView.controller.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.controller.delegate = self;
    [self.panelView.controller.floatButton setTarget:self];
    [self.panelView.controller.floatButton setAction:@selector(toggleFloatMode:)];
}

- (void)togglePanel:(NSString *)panelId state:(BOOL)state {
    if (state)
        [self.panelView.controller scrollToPanel:panelId];
}

- (void)toggleMain:(BOOL)state{
    if (constraint == nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self.panelView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem: self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
        [self.view addConstraint:constraint];
    }
    _minWidth = state? 280 : 40;
    _maxWidth = state? 9999  : 40;
    if (windowMod) {
        _minWidth = _maxWidth = 40;
    }
    [self viewWillLayout];
}

- (void)toggleFloatMode:(NSButton *) button{
    if (button.state) {
        // open float window
        [self showWindow];
    } else {
        [self showSlider];
        // close float window
    }
}

- (void)showWindow {
    NSLog(@"### windowMod %hhd", windowMod);
    if (windowMod) {
        [window makeKeyAndOrderFront:window];
        return;
    }
    windowMod = YES;
    
    NSLog(@"### windowMod------");
    NSRect frame = NSMakeRect(0, 0, self.panelView.frame.size.width, self.panelView.frame.size.height);
    NSLog(@"### NSMakeRect------");
    NSRect rect = [NSWindow contentRectForFrameRect:frame styleMask:NSWindowStyleMaskBorderless];
    NSWindowStyleMask mask = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable | NSWindowStyleMaskClosable;
    NSLog(@"### window------");
    if (window == nil)
        window = [[NSWindow alloc] initWithContentRect:rect styleMask:mask backing:NSBackingStoreBuffered defer:false];
    NSLog(@"### window------ebd %@", window);
    window.titleVisibility = NSWindowTitleVisible;
    [window setTitle:@"无极Skecth UIKit设计工具"];
    [window center];
    NSLog(@"### window------111");
    [window makeKeyAndOrderFront:window];
    window.delegate = self;
    NSLog(@"### window------222");
    window.contentView = self.panelView.controller.view;
    NSLog(@"### window------333");
    [window setAutorecalculatesKeyViewLoop:true];
    NSLog(@"### window------444");
    _minWidth = _maxWidth = 40;
    [self viewWillLayout];
    NSLog(@"### window------555");
}
- (void)showSlider{
    window.contentView = nil;
    window.delegate = nil;
    [window setIsVisible:NO];
    [self windowWillClose:nil];
}

- (BOOL)windowShouldClose:(NSWindow *)sender{
    windowMod = NO;
    constraint = nil;
    [self.panelView resumeView];
    [self toggleMain:YES];
    return NO;
}

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp stopModal];
    windowMod = NO;
    constraint = nil;
    [self.panelView resumeView];
    [self toggleMain:YES];
}

-  (void)viewWillLayout {
    [super viewWillLayout];
    if (self.delegate) {
        [self.delegate viewWillLayout];
    }
}

@end
