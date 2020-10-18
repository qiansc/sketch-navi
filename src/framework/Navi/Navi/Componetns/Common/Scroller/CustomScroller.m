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

//- (void)drawKnob{
//    NSRect knobRect = [self rectForPart:NSScrollerKnob];
//    NSRect newRect = NSMakeRect(knobRect.origin.x+3, knobRect.origin.y, knobRect.size.width-6, knobRect.size.height);
//    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:5 yRadius:5];
//    NSGradient *gradient = [[NSGradient alloc] initWithColorsAndLocations:
//                            [NSColor colorWithRed:0.0 green:0.91 blue:0.0 alpha:0.00],0.0,
//                            [NSColor colorWithRed:0.6 green:0.1 blue:0.1 alpha:0.00], 1.0,
//                            nil];
//    [gradient drawInBezierPath:path angle:0];
//}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor clearColor]setFill];
    NSRectFill(dirtyRect);
    [self drawKnob];
}


//背景色
//-(NSColor *)backgroundColor{
//    if (!_backgroundColor) {
//        //        _backgroundColor = [NSColor whiteColor];
//        _backgroundColor = [NSColor clearColor];
//    }
//    return [NSColor blackColor];
//}

@end
