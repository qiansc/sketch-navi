//
//  CustomScroller.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "CustomScroller.h"

@implementation CustomScroller
- (void)drawKnob {
    [super drawKnob];

    NSRect knobRect = NSInsetRect([self rectForPart:NSScrollerKnob], 10, 0);
    NSBezierPath *bezierPath = [NSBezierPath bezierPathWithRoundedRect:knobRect xRadius:5 yRadius:5];
    [[NSColor systemGrayColor] set];
    [bezierPath fill];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor clearColor]setFill];
    NSRectFill(dirtyRect);
    [self drawKnob];
}

@end
