//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorPanel.h"
#import "NVCollectionController.h"
#import "NVColorSource.h"
#import "NVColorCollectionItemView.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel {
    NVColorSpec spec;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建NVCollectionController 并把他的视图指向到xib存在的那个collectionView上去
    NVCollectionController *c = [[NVCollectionController alloc]init];
    [c setCollectionView: self.collectionView];
    // 绑定重绘
    c.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };
    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * _Nonnull box) {
        spec = ((NVColorCollectionItemView *)box).spec;
        [self update];
    }];
    [self update];
}

-(void)update {
    self.headerView.infoButton.title = spec.specCode;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.source;
}

@end
