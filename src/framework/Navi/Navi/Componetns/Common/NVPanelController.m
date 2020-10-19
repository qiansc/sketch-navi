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
    [self.headerView.toggleButton setTarget:self];
    [self.headerView.toggleButton setAction:@selector(toogle:)];
    openState = self.headerView.toggleButton.state;
    [self resetConstraint];
//    self.view.wantsLayer = true;
//    self.view.layer.backgroundColor = [NSColor purpleColor].CGColor;
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
    // 已经关闭
    [self.view addConstraint:constraintHeight];
    if (self.panelDelegate) {
        [self.panelDelegate panelDidResize:self.panelId];
    }

}

- (void)toogle:(NSButton*) button{
    openState = self.headerView.toggleButton.state;
    [self resetConstraint];
    if (self.panelDelegate) {
        [self.panelDelegate panel:self.panelId changeState:openState];
    }
}

- (instancetype) initWithId:(NSString*) id {
    self.panelId = id;
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return [self initWithNibName:[NSString stringWithFormat:@"NV%@Panel", id] bundle: resourceBundlePath];
}

- (int)height {
    // float height = 0;
    float addHeight = 0;
    for(NSView* view in self.view.subviews) {
//        NSLog(@"XXXXXXXIIIII %@ %f, %f", self.panelId, view.frame.size.height, view.frame.origin.y);
//        float h = view.frame.size.height + view.frame.origin.y;
//        height = h > height ? h : height;
        addHeight += view.frame.size.height;
    }
    // height = height < 50 ? addHeight : height;
    return addHeight;
}

- (NSObject<NVSource> *)generatePanelSource {
    return [NSObject new];
}
@end
