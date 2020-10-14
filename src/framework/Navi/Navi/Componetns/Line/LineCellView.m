//
//  LineCellView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "LineCellView.h"

@implementation LineCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    [self updateState];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.hover = YES;
    [self updateState];
    
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.hover = NO;
    [self updateState];
};

- (void)mouseDown:(NSEvent *)event {
}

- (void)mouseUp:(NSEvent *)event {
    self.selected = YES;
    [self updateState];
    [self.target performSelector:self.action withObject:self];
}

// 用于追踪mouseEntered / mouseExited
- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
    
    [self addTrackingArea:self.trackingArea];
}

- (void) updateState {}

@end
