//
//  NVImage.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVImage.h"

@implementation NVImage

+ (NSImage *)imageNamed:(NSImageName)name {
    return [[NSBundle bundleForClass:[self class]] imageForResource:name];
}

@end
