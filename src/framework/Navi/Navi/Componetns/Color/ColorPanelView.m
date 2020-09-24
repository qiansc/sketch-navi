//
//  ColorPanelView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorPanelView.h"
#import "ColorPanel.h"

@implementation ColorPanelView


- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    
    self.view = [ColorPanel viewControllerFromNIB].view;
    
    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
    self.view.frame = contentFrame;

    [self addSubview:self.view];

    return self;
};



- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];

    self.view = [ColorPanel viewControllerFromNIB].view;

    NSRect contentFrame = NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height);
    self.view.frame = contentFrame;

    [self addSubview:self.view];

    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
