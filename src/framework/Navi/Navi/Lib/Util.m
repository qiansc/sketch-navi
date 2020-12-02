//
//  Util.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Util.h"
#import "HexColor.h"
#import "MSDocument.h"

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

+ (void)position:(MSLayer*)layer at:(CGPoint) point {
    CGPoint parentOffset = [Util parentOffsetInArtboard:layer];
    layer.frame.x = point.x - parentOffset.x;
    layer.frame.y = point.y - parentOffset.y;
}

+ (CGPoint)parentOffsetInArtboard:(MSLayer*)layer {
    CGPoint offset = {.x=0,.y=0};
    MSLayer *parent = layer.parentObject;
    
    while (parent && parent.parentObject) {
        offset.x += parent.frame.x;
        offset.y += parent.frame.y;
        parent = parent.parentObject;
        if ([parent.className containsString:@"MSArtboard"]) {
            parent = nil;
        }
    }
    
    return offset;
}

+ (void)message:(NSString *) string{
    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:string];
}

@end
