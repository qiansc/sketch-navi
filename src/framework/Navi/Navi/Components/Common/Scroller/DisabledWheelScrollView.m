//
//  DisabledWheelScrollView.m
//  Navi
//
//  Created by QIANSC on 2020/10/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "DisabledWheelScrollView.h"

@implementation DisabledWheelScrollView


- (void)scrollWheel:(NSEvent *)theEvent {

    [[self nextResponder] scrollWheel:theEvent];
    [[self nextResponder] scrollWheel:theEvent];

}

@end
