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
#import "NVUserData.h"
#import "Util.h"

@interface NVPerference ()

@end

@implementation NVPerference

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NVLogin *xib = [[NVLogin alloc] initWithNibName:@"NVLogin" bundle: [NVBundle bundlePath]];

    [self.accountItem addSubview:self.accountLoginView];
    [self.accountItem addSubview:self.accountUserView];
    [self.aboutItem addSubview:self.aboutView];
    [self.commonItem addSubview:self.commonView];
    [self.loginController viewDidLoad];
    [self.commonController viewDidLoad];

}


#pragma mark - NSTabViewDelegate

//- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem{
//    if ([tabViewItem.identifier isEqual:@"common"]) {
//        NSDictionary *data = [NVUserData userData];
//        NSLog(@"### data %@", data, data[@"username"]);
//        if (!data[@"username"]) {
//            [self.tabView selectTabViewItemAtIndex:0];
//            [Util message:@"请登录后操作！"];
//        }
//    }
//}

//已点击item
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem{
    if ([tabViewItem.identifier isEqual:@"common"]) {
        NSDictionary *data = [NVUserData userData];
        if (!data[@"username"]) {
            [self.tabView selectTabViewItemWithIdentifier:@"login"];
            [Util message:@"请登录后操作！"];
        } else {
            [self.commonController updateView];
        }
    }
}


@end
