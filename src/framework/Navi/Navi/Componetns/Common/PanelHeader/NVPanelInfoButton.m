//
//  NVPanelInfoButton.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanelInfoButton.h"
#import "MSDocument.h"

@implementation NVPanelInfoButton {
    NSTrackingArea* trackingArea;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

-(void)setTitle:(NSString *)newTitle{
    if (newTitle) {
        [super setTitle:newTitle];
        [self setHidden:NO];
    } else {
        [super setTitle:@" "];
        [self setHidden:YES];
    }
}

// 用于追踪mouseEntered / mouseExited
- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if(trackingArea) {
        [self removeTrackingArea:trackingArea];
        trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
    
    [self addTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)event {

}

- (void)mouseExited:(NSEvent *)event {

}

- (void)mouseDown:(NSEvent *)event {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];  //必须清空，否则setString会失败。
    [pasteboard setString:self.title forType:NSPasteboardTypeString];
    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"已复制 %@ 到剪切板", self.title]];
}

- (void)mouseUp:(NSEvent *)event {

}

@end
