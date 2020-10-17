//
//  PanelHeader.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "PanelHeader.h"

@interface PanelHeader ()

@end

@implementation PanelHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.toggleButton setTarget:self];
    [self.toggleButton setAction:@selector(toogle:)];
    self.view.wantsLayer = true;
    self.view.layer.backgroundColor = [NSColor orangeColor].CGColor;
    // self.toggleButton
    // Do view setup here.
}

- (void)toogle:(NSButton*) sender{
    NSView* view = self.view.superview.superview;
    NSRect contentFrame = NSMakeRect(0, 0, view.frame.size.width, self.view.frame.size.height);
    view.frame = contentFrame;
    view.wantsLayer = true;
    view.layer.backgroundColor = [NSColor greenColor].CGColor;
}


+ (instancetype)viewControllerFromNIB {
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return [[PanelHeader alloc] initWithNibName:@"PanelHeader" bundle:resourceBundlePath];
}


@end
