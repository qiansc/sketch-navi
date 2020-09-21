//
//  ColorMiniPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorMiniPanel.h"

@interface ColorMiniPanel ()

@end

@implementation ColorMiniPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

+ (instancetype)viewControllerFromNIB {
    
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return [[ColorMiniPanel alloc] initWithNibName:@"ColorMiniPanel" bundle:resourceBundlePath];
}

@end
