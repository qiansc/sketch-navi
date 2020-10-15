//
//  FlippedClipView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "FlippedClipView.h"

@implementation FlippedClipView

- (BOOL)isFlipped {
    // 反转坐标系
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
