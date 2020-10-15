//
//  NVPanelController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanelController.h"

@interface NVPanelController ()

@end

@implementation NVPanelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openState = 0;
    [self.headerView.toggleButton setTarget:self];
    [self.headerView.toggleButton setAction:@selector(toogle:)];
    [self toogle:nil];
}

-(void)setOpenStateSlient:(NSControlStateValue)state {
     self.openState = state;
    if (self.openState != self.headerView.toggleButton.state) {
        [self.headerView.toggleButton setNextState];
    }
     [self resetConstraint];
}

- (void)resetConstraint {
    // 首次或者每次重绘必须执行此句，来保证在NSStack视图中位置ok
    [self.view removeConstraint:self.constraintHeight];
    if (self.openState == YES){
        // 展开状态
        self.constraintHeight = [self.view.heightAnchor constraintEqualToConstant:self.headerView.frame.size.height + 100];
    } else {
        // 隐藏状态
        self.constraintHeight = [self.view.heightAnchor constraintEqualToConstant:self.headerView.frame.size.height];
    }
    // 已经关闭
    [self.view addConstraint:self.constraintHeight];
}

- (void)toogle:(NSButton*) button{
    self.openState = self.headerView.toggleButton.state;
    [self resetConstraint];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DID_CHANGE_PANEL_ON" object:nil userInfo:@{
        @"state": @(self.openState),
        @"panelId": self.panelId
    }];
}

- (instancetype) initWithId:(NSString*) id {
    self.panelId = id;
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return [self initWithNibName:[NSString stringWithFormat:@"NV%@Panel", id] bundle: resourceBundlePath];
}

@end
