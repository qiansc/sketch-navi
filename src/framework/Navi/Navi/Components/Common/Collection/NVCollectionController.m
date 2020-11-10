//
//  NVCollectionController.m
//  Navi
//
//  Created by QIANSC on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCollectionController.h"

@implementation NVCollectionController
{
    float height, width;
}

- (void)viewDidLayout {
    [super viewDidLayout];
    NSRect frame = self.view.superview.frame;
    self.view.superview.needsLayout = YES;
    [self.view.superview layout];
}

@end
