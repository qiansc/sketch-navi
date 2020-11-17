//
//  NVPanelView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import "Util.h"
#import "NVPanelView.h"
#import "NVBundle.h"

@implementation NVPanelView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    self.controller = [[Panel alloc] initWithNibName:@"Panel" bundle:[NVBundle bundlePath]];
    [self addSubview: self.controller.view];
    [Util fillSuperview: self.controller.view];
    return self;
};


- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    self.controller = [[Panel alloc] initWithNibName:@"Panel" bundle:[NVBundle bundlePath]];
    [self addSubview: self.controller.view];
    [Util fillSuperview: self.controller.view];
    return self;
}

- (void)resumeView{
    [self addSubview: self.controller.view];
    [Util fillSuperview: self.controller.view];
}

@end
