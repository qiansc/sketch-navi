//
//  MSColor.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSColor.h"
#import "HexColor.h"

@implementation MSColor
+ (instancetype)colorWithRed:(double)arg1 green:(double)arg2 blue:(double)arg3 alpha:(double)arg4 {
    return [NSClassFromString(@"MSColor") colorWithRed:arg1 green:arg2 blue:arg3 alpha:arg4];
}

+ (instancetype)fromHexColorString:(NSString *) hexString {
    NSColor *color = NSColorFromRGBString(hexString);
    return [NSClassFromString(@"MSColor") colorWithRed:color.redComponent * 255 green:color.greenComponent * 255 blue:color.blueComponent * 255 alpha:color.alphaComponent];
}

+ (instancetype)fromHexColorString:(NSString *) hexString withAlpha: (double) alpha {
    NSColor *color = NSColorFromRGBString(hexString);
    return [NSClassFromString(@"MSColor") colorWithRed:color.redComponent * 255 green:color.greenComponent * 255 blue:color.blueComponent * 255 alpha:alpha];
}
@end
