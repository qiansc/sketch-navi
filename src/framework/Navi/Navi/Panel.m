//
//  PanelController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Panel.h"

@implementation Panel

- (void)viewDidLoad {
    [super viewDidLoad];
}
-  (void)viewWillLayout {
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
    if (self.delegate) {
        [self.delegate viewWillLayoutSize:[NSString stringWithFormat:@"%f,%f", self.view.frame.size.width, self.view.frame.size.height]];
    }
}

+ (instancetype)viewControllerFromNIB {
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return[[Panel alloc] initWithNibName:@"Panel" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

- (void)layoutSection {
    NSLog(@"NAVIL %@", [Menu instance]);
}

@end
