//
//  MenuItem.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/14.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MenuItemView.h"

@implementation MenuItemView

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    
    [[NSBundle mainBundle] loadNibNamed:@"MenuItemView" owner:self topLevelObjects:nil];
    
    // This 2 line codes makes XIB View size same
    // Alternates code:
    // self.view.fame = self.bounds
    NSRect contentFrame = NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height);
    self.view.frame = contentFrame;
    
    NSLog(@"NSLOG1: %f %f", frameRect.size.width, frameRect.size.height);
    [self addSubview:self.view];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    [[NSBundle mainBundle] loadNibNamed:@"MenuItemView" owner:self topLevelObjects:nil];
    
    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
    self.view.frame = contentFrame;
    NSLog(@"NSLOG2: %f %f", self.frame.size.width, self.frame.size.height);
    [self addSubview:self.view];
    
    return self;
};

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
