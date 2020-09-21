//
//  ColorMiniButtonView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorMiniButtonView.h"

@implementation ColorMiniButtonView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
//    [[NSColor yellowColor] setFill];
//    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    [self setBezelStyle:NSBezelStyleRegularSquare];
    [self setButtonType:NSButtonTypeToggle];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor yellowColor].CGColor;
    [self setState:(NSControlStateValueOn)];

    // Drawing code here.
}


@end
