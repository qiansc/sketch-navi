//
//  LinePanelView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "LinePanelView.h"
#import "LinePanel.h"

@implementation LinePanelView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    self.linePanelController = [LinePanel viewControllerFromNIB];
    self.view = self.linePanelController.view;

    self.view.frame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);

    [self addSubview:self.view];


    return self;
}

- (id)initWithFrame:(NSRect)frameRect {

    self = [super initWithFrame:frameRect];

    self.linePanelController = [LinePanel viewControllerFromNIB];

    self.view = self.linePanelController.view;

    self.view.frame = NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height);

    [self addSubview:self.view];

    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}

@end
