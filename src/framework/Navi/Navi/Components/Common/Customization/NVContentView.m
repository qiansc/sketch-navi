//
//  NVContentView.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVContentView.h"
#import "NVColor.h"

@implementation NVContentView

- (void)drawRect:(NSRect)dirtyRect {
    [[NVColor colorNamed:@"ContentBackground"] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
