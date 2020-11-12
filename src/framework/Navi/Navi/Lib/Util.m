//
//  Util.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Util.h"
#import "HexColor.h"

@implementation Util

+ (NSImage*)createImage:(NSURL*) imageURL withSize:(NSSize) size {
    NSImage* image = [[NSImage alloc]initWithContentsOfURL:imageURL];
    [image setSize:size];
    [image setScalesWhenResized:YES];
    return image;
}

+ (NSBox*)separtorBox {
    NSBox *separtorBox = [[NSBox alloc]initWithFrame:NSZeroRect];
    [separtorBox setBoxType:NSBoxSeparator];
    [separtorBox setBorderColor:NSColorFromRGBString(@"#F5F5F5")];
    return separtorBox;
}

+ (void)fillSuperview:(NSView*)view{
    NSView *superview = view.superview;
    view.frame = NSMakeRect(0, 0, superview.frame.size.width, superview.frame.size.height);
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}
@end
