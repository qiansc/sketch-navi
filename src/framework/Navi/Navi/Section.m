//
//  Section.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Section.h"

@implementation Section

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

+ (instancetype)viewControllerFromNIB {
    
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return [[Section alloc] initWithNibName:@"Section" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

@end
