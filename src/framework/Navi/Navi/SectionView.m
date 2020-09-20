//
//  SectionView.m
//  Navi
//
//  Created by QIANSC on 2020/9/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "SectionView.h"
#import "Section.h"

@implementation SectionView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    
    self.view = [Section viewControllerFromNIB].view;
    
    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
    self.view.frame = contentFrame;

    [self addSubview:self.view];

    return self;
};



- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];

    self.view = [Section viewControllerFromNIB].view;

    // This 2 line codes makes XIB View size same
    // Alternates code:
    // self.view.fame = self.bounds
    NSRect contentFrame = NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height);
    self.view.frame = contentFrame;

    [self addSubview:self.view];

    return self;
}

//- (id)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//
//    [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self topLevelObjects:nil];
//
//    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
//    self.view.frame = contentFrame;
//
//    [self addSubview:self.view];
//
//    return self;
//};

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
