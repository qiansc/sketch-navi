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

@interface NVColorPanel ()

@end

@implementation NVColorPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册CollectionView 相关
    NVCollectionController *c = [[NVCollectionController alloc]init];
    c.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };
    [c setCollectionView: self.collectionView];
 
}

-(NVPanelSource *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.source;
}

@end
