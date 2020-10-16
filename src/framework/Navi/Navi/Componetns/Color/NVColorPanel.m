//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorPanel.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayout {
    [super viewWillLayout];
    NSLog(@"NAVIL LAYOUT");
}

- (int)height{
    NSLog(@"NAVIL Height %@ %@ %f, %f",self.collectionView, self.collectionView.superview, self.collectionView.superview.frame.size.height, self.collectionView.frame.size.height);
    if (self.collectionView.superview.frame.size.height == 0) {
        return 200;
    } else {
        return self.collectionView.superview.frame.size.height + self.headerView.frame.size.height;
    }
}

@end
