//
//  MenuBtn.m
//  SimpleBindings
//
//  Created by Qian,Sicheng on 2020/9/14.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MenuBtn.h"

@implementation MenuBtn

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    
    [[NSBundle mainBundle] loadNibNamed:@"MenuBtn" owner:self topLevelObjects:nil];
    
    // This 2 line codes makes XIB View size same
    // Alternates code:
    // self.view.fame = self.bounds
    NSRect contentFrame = NSMakeRect(0, 0, frameRect.size.width, frameRect.size.height);
    self.view.frame = contentFrame;
    
    [self addSubview:self.view];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    [[NSBundle mainBundle] loadNibNamed:@"MenuBtn" owner:self topLevelObjects:nil];
    
    NSRect contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height);
    self.view.frame = contentFrame;
    
    [self addSubview:self.view];
    
    return self;
};

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
