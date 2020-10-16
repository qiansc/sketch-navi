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
    openState = 0;
    [self.headerView.toggleButton setTarget:self];
    [self.headerView.toggleButton setAction:@selector(toogle:)];
    [self toogle:nil];
}


-(void)setOpenStateSlient:(NSControlStateValue)state {
     openState = state;
    if (openState != self.headerView.toggleButton.state) {
        [self.headerView.toggleButton setNextState];
    }
     [self resetConstraint];
}

- (void)resetConstraint {
    // 首次或者每次重绘必须执行此句，来保证在NSStack视图中位置ok
    [self.view removeConstraint:constraintHeight];
    if (openState == YES){
        // 展开状态
        constraintHeight = [self.view.heightAnchor constraintEqualToConstant: [self height]];
    } else {
        // 隐藏状态
        constraintHeight = [self.view.heightAnchor constraintEqualToConstant:self.headerView.frame.size.height];
    }
    NSLog(@"NAVIL RESC%@, %@", self.panelId, constraintHeight);
    // 已经关闭
    [self.view addConstraint:constraintHeight];
}

- (void)toogle:(NSButton*) button{
    openState = self.headerView.toggleButton.state;
    [self resetConstraint];
    if (self.stateChangeDelegate) {
        [self.stateChangeDelegate panel:self.panelId changeState:openState];
    }
}

- (instancetype) initWithId:(NSString*) id {
    self.panelId = id;
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return [self initWithNibName:[NSString stringWithFormat:@"NV%@Panel", id] bundle: resourceBundlePath];
}

- (int)height {
    return 200;
}

@end
