//
//  NVPanelController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanelController.h"
#import "NVCollectionView.h"

@interface NVPanelController ()

@end

@implementation NVPanelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerView.toggleButton setTarget:self];
    [self.headerView.toggleButton setAction:@selector(toogle:)];
    openState = self.headerView.toggleButton.state;
}

#pragma mark toogle state

- (void)toogle:(NSButton*) button{
    openState = self.headerView.toggleButton.state;
    [self resetConstraint];
    if (self.panelDelegate) {
        [self.panelDelegate panel:self.panelId changeState:openState];
    }
}


-(void)setOpenStateSlient:(NSControlStateValue)state {
     openState = state;
    if (openState != self.headerView.toggleButton.state) {
        [self.headerView.toggleButton setNextState];
    }
    [self resetConstraint];
}

- (void)setSemanticMode:(BOOL)mode {
    semanticMode = mode;
}

#pragma mark layout

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
}


#pragma mark init

- (instancetype) initWithId:(NSString*) id {
    self.panelId = id;
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return [self initWithNibName:[NSString stringWithFormat:@"NV%@Panel", id] bundle: resourceBundlePath];
}

- (int)height {
    float newHeight = 0;
    for(NSView* view in self.view.subviews) {
        if (view.isHidden == YES) continue;
        float h = 0;
        if ([view isKindOfClass: [NVCollectionView class]]) {
            h = ((NVCollectionView*) view).displayHeight;
        } else {
            h = view.frame.size.height;
        }
        float offsetY = self.view.frame.size.height - view.frame.size.height - view.frame.origin.y;
        newHeight = offsetY + h;
    }
    return newHeight+10;
}


#pragma mark should to be complete

- (NSObject<NVSource> *)generatePanelSource {
    return nil;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers {
    // do sth
}

- (void)viewDidLayout{
    [super viewDidLayout];
    [self resetConstraint];
}


@end
