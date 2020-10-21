//
//  NVPanelInfoButton.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanelInfoButton.h"

@implementation NVPanelInfoButton

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}
-(void)setTitle:(NSString *)newTitle{
    if (newTitle) {
        [super setTitle:newTitle];
        [self setHidden:NO];
    } else {
        [super setTitle:@" "];
        [self setHidden:YES];
    }
}
@end
