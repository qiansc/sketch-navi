//
//  NVTrackButton.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVTrackButton.h"

@implementation NVTrackButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

// 用于追踪mouseEntered / mouseExited
//- (void)updateTrackingAreas {
//    [super updateTrackingAreas];
//    if(self.trackingArea) {
//        [self removeTrackingArea:self.trackingArea];
//        self.trackingArea = nil;
//    }
//    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
//    self.trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
//    
//    [self addTrackingArea:self.trackingArea];
//}

@end
