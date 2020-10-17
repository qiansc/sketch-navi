//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorPanel.h"
#import "ColorCollection.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel {
    NSLayoutConstraint* constraintBSHeight;
    float bHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ColorCollection *c = [[ColorCollection alloc]init];
//    c.view.autoresizingMask = self.clipView.subviews[0].autoresizingMask;
//    c.view.autoresizesSubviews = self.clipView.subviews[0].autoresizesSubviews;
//    [self.clipView.subviews[0] removeFromSuperview];
//    [self.clipView addSubview:c.view];
    c.layoutHandler = ^(float num) {
        [self setBHeight:num];
        [self resetConstraint];
         NSLog(@"NAVIL AFTER CCCCC %f %f %f", self.view.frame.size.height, self.bView.frame.size.height, self.clipView.frame.size.height);
    };
    
    self.collectionView = c.view = self.clipView.subviews[0];

    self.clipView.wantsLayer = true;
    self.clipView.layer.backgroundColor = [NSColor purpleColor].CGColor;
    NSLog(@"NAVIL %hhd %lu", c.view.autoresizesSubviews, (unsigned long)c.view.autoresizingMask);
    
    [self setBHeight:50];
    
}

- (void)setBHeight:(float) height {
    bHeight = height;
    [self.bView removeConstraint:constraintBSHeight];
    constraintBSHeight = [self.bView.heightAnchor constraintEqualToConstant: bHeight];
    [self.bView addConstraint:constraintBSHeight];
    
}


- (void)viewWillLayout {
    [super viewWillLayout];
    NSLog(@"NAVIL viewWillLayout %f %f %f", self.view.frame.size.height, self.bView.frame.size.height, self.clipView.frame.size.height);
}

- (void)viewDidLayout {
    NSLog(@"NAVIL viewDidLayout-START %f %f %f", self.view.frame.size.height, self.bView.frame.size.height, self.clipView.frame.size.height);
    [super viewDidLayout];
    NSLog(@"NAVIL viewDidLayout-END %f %f %f", self.view.frame.size.height, self.bView.frame.size.height, self.clipView.frame.size.height);
}

- (int)height{
    if (self.collectionView.superview.frame.size.height == 0) {
        NSLog(@"NAVIL HEIGHT888");
        return 200;
    } else {
        NSLog(@"NAVIL HEIGHT999 %f", self.collectionView.frame.size.height);
        return self.collectionView.frame.size.height + self.headerView.frame.size.height;
    }
}

@end
