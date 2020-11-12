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
    [Util fillSuperview: controller.view];
    return self;
};


- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    Menu *controller = [[Menu alloc] initWithNibName:@"Menu" bundle:[NVBundle bundlePath]];
    [self addSubview: controller.view];
    [Util fillSuperview: controller.view];
    return self;
}

@end
