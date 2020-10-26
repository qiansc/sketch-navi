//
//  NVPanelHeader.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanelHeader.h"
#import "MSDocument.h"

@interface NVPanelHeader ()

@end

@implementation NVPanelHeader

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.toggleButton setTarget:self];
//    [self.toggleButton setAction:@selector(toogle:)];
    // self.view.wantsLayer = true;
    // self.view.layer.backgroundColor = [NSColor orangeColor].CGColor;
    // self.toggleButton
    // Do view setup here.
    [self.infoButton setTitle:nil];
    [self.infoButton setTarget:self];
    [self.infoButton setAction:@selector(copyInfo:)];
}

-(void)copyInfo:(NSButton*) button{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];  //必须清空，否则setString会失败。
    [pasteboard setString:button.title forType:NSPasteboardTypeString];
    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"已复制 %@ 到剪切板", button.title]];
}

- (void)toogle:(NSButton*) sender{
//    NSView* view = self.view.superview.superview;
//    NSRect contentFrame = NSMakeRect(0, 0, view.frame.size.width, self.view.frame.size.height);
//    view.frame = contentFrame;
}


+ (instancetype)viewControllerFromNIB {
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return [[NVPanelHeader alloc] initWithNibName:@"NVPanelHeader" bundle:resourceBundlePath];
}


@end
