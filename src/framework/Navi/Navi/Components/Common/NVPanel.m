//
//  NVPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanel.h"
#import "NVCollectionView.h"
#import "NVBundle.h"
#import "NVImage.h"

@implementation NVPanel{
    NSControlStateValue openState;
    NSLayoutConstraint* constraintHeight;
    BOOL semanticMode;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    openState = YES;
    [self.headerView.controller.toggleButton setTarget:self];
    [self.headerView.controller.toggleButton setAction:@selector(toogle:)];
    [self.headerView.controller.toggleBackgroundButton setTarget:self];
    [self.headerView.controller.toggleBackgroundButton setAction:@selector(toogle:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear {
    [super viewDidAppear];
}
#pragma mark toogle state

- (void)toogle:(NSButton*) button{
    openState = !openState;
    [self resetConstraint];
    if (self.panelDelegate) {
        [self.panelDelegate panel:self.panelId changeState:openState];
    }
}


-(void)setStateSlient:(NSControlStateValue)state {
    if (openState != state) {
        openState = state;
        [self resetConstraint];
    }
}

#pragma mark layout

- (void)resetConstraint {
    // 首次或者每次重绘必须执行此句，来保证在NSStack视图中位置ok
    [self.view removeConstraint:constraintHeight];
    self.headerView.controller.toggleButton.image = [NVImage imageNamed:openState? @"ArrowDown" : @"ArrowRight"];
    if (openState == YES){
        // 展开状态
        // [self.view setHidden:NO];
        constraintHeight = [self.view.heightAnchor constraintEqualToConstant: [self height]];
    } else {
        // 隐藏状态
        // [self.view setHidden:YES];
        constraintHeight = [self.view.heightAnchor constraintEqualToConstant:self.headerView.frame.size.height];
        // constraintHeight = [self.view.heightAnchor constraintEqualToConstant:0];
    }
    // 已经关闭
    [self.view addConstraint:constraintHeight];
}


#pragma mark init

- (instancetype) initWithId:(NSString*) id {
    self.panelId = id;
    return [self initWithNibName:[NSString stringWithFormat:@"NV%@Panel", id] bundle: [NVBundle bundlePath]];
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
    return newHeight + 30;
}


#pragma mark should to be complete

- (NSObject<NVSource> *)generatePanelSource {
    return nil;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers {
    // do sth
}

- (void)onPaste:(NSArray<MSLayer*>*) layers {
    // do sth
}

- (void)viewDidLayout{
    [super viewDidLayout];
    [self resetConstraint];
}


@end
