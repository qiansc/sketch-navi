//
//  MenuView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMenuView.h"
#import "Menu.h"
#import "NVBundle.h"

@implementation NVMenuView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    Menu *controller = [[Menu alloc] initWithNibName:@"Menu" bundle:[NVBundle bundlePath]];


    [self addSubview: controller.view];
//    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, 30);
//    controller.view.frame = contentFrame;
//    self.infoButton = controller.infoButton;
//    self.titleLabel = controller.titleLabel;
//    self.toggleButton = controller.toggleButton;

// 没有no-arc之前必须加约束才出来
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
//
    return self;
};


- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    Menu *controller = [[Menu alloc] initWithNibName:@"Menu" bundle:[NVBundle bundlePath]];

    [self addSubview: controller.view];
    return self;
}

@end
