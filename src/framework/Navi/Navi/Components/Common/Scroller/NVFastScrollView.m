//
//  NVFastScrollView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVFastScrollView.h"

@implementation NVFastScrollView

- (void)scrollWheel:(NSEvent *)theEvent {
    [super scrollWheel:theEvent];
    [super scrollWheel:theEvent];
//    [[self nextResponder] scrollWheel:theEvent];
//    [[self nextResponder] scrollWheel:theEvent];
    // NSLog(@"### DisabledWheelScrollView", self.frame.size.height);

}

@end
