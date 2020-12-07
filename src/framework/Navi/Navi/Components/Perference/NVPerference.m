//
//  NVPerference.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPerference.h"
#import "NVBundle.h"
#import "NVLogin.h"

@interface NVPerference ()

@end

@implementation NVPerference

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NVLogin *xib = [[NVLogin alloc] initWithNibName:@"NVLogin" bundle: [NVBundle bundlePath]];

    [self.accountItem addSubview:self.accountLoginView];
    [self.accountItem addSubview:self.accountUserView];
    [self.aboutItem addSubview:self.aboutView];
    [self.loginController viewDidLoad];
}

@end
