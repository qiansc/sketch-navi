//
//  MenuController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MenuController.h"

@interface MenuController ()

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPreferredContentSize:CGSizeMake(40, 450)];
    [self.view setAutoresizingMask:NSViewNotSizable];
    
}
-  (void)viewWillLayout {
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
}

+ (instancetype)viewControllerFromNIB {
    
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return[[MenuController alloc] initWithNibName:@"Menu" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}
- (void)viewDidAppear{
//    [self.view setFrameSize:NSMakeSize(40, 450)];
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
}
- (void)didReceiveMemoryWarning {
    // [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
