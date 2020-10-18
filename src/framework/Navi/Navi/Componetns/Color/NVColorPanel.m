//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorPanel.h"
#import "NVCollectionController.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    NVCollectionController *c = [[NVCollectionController alloc]init];
    c.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };
    [c setCollectionView: self.collectionView];
}

@end
