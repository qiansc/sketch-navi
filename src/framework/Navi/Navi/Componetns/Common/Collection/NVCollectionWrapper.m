//
//  NVCollectionWrapper.m
//  Navi
//
//  Created by QIANSC on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCollectionWrapper.h"

/* 主要用来限定容器高度并且在变化时触发delegate */
@implementation NVCollectionWrapper {
    float height;
    NSLayoutConstraint* constraintBSHeight;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)setHeight:(float) newHeight {
    
    height = newHeight;
    [self removeConstraint:constraintBSHeight];
    constraintBSHeight = [self.heightAnchor constraintEqualToConstant: height];
    [self addConstraint:constraintBSHeight];
    NSRect frame = self.frame;
    self.frame = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, height);
}

@end
