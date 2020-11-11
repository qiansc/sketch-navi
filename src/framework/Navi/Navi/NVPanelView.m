//
//  NVPanelView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import "Panel.h"
#import "NVPanelView.h"
#import "NVBundle.h"

@implementation NVPanelView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    Panel *controller = [[Panel alloc] initWithNibName:@"Panel" bundle:[NVBundle bundlePath]];


    [self addSubview: controller.view];

    return self;
};


- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    Menu *controller = [[Menu alloc] initWithNibName:@"Menu" bundle:[NVBundle bundlePath]];

    [self addSubview: controller.view];
    return self;
}

@end
