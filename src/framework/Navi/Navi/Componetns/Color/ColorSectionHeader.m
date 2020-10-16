//
//  ColorSectionHeader.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorSectionHeader.h"

@implementation ColorSectionHeader

- (void)willMoveToSuperview:(NSView *)superview{
    [super viewWillMoveToSuperview:superview];
    NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
    textField.stringValue = @"Header Title";
    [self addSubview: textField];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
