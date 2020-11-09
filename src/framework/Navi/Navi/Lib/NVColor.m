//
//  NVColor.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColor.h"

@implementation NVColor

+(NSColor *)colorNamed:(NSColorName)name {
    return [NSColor colorNamed:name bundle:[NSBundle bundleForClass:[self class]]];
}

@end

// NSBundle *frameworkBundle = [NSBundle bundleForClass:[Menu class]];
// NSURL *imageURL = [NSURL fileURLWithPath:[frameworkBundle pathForResource: @"main" ofType:@"png"]];
// NSImage* image = [[NSImage alloc]initWithContentsOfURL:imageURL];
