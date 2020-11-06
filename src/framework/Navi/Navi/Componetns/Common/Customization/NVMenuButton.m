//
//  NVMenuButton.m
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMenuButton.h"

@implementation NVMenuButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.{
    if(self.state)
        self.layer.backgroundColor = nil;
        // self.layer
    else
        self.layer.backgroundColor = nil;
}

@end
