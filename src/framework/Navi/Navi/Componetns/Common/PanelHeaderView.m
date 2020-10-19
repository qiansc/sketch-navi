//
//  PanelHeaderView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "PanelHeaderView.h"
#import "PanelHeader.h"

@implementation PanelHeaderView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    PanelHeader *controller = [PanelHeader viewControllerFromNIB];
    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
    controller.view.frame = contentFrame;
    [self addSubview: controller.view];
    self.infoButton = controller.infoButton;
    self.titleLabel = controller.titleLabel;
    self.toggleButton = controller.toggleButton;

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
    PanelHeader *controller = [PanelHeader viewControllerFromNIB];
    controller.view.frame = self.bounds;
//    NSRect contentFrame = NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height);
//    view.frame = contentFrame;
    [self addSubview:controller.view];
    self.infoButton = controller.infoButton;
    self.titleLabel = controller.titleLabel;
    self.toggleButton = controller.toggleButton;
    return self;
}

@end
