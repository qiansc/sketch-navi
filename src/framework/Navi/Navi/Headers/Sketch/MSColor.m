//
//  MSColor.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSColor.h"

@implementation MSColor
+ (id)colorWithRed:(double)arg1 green:(double)arg2 blue:(double)arg3 alpha:(double)arg4 {
    return [NSClassFromString(@"MSColor") colorWithRed:arg1 green:arg2 blue:arg3 alpha:arg4];
}
@end
