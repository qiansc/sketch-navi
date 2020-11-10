//
//  NVMaskCollectionItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMaskCollectionItemView.h"
#import "HexColor.h"
#import "QuartzCore/CAGradientLayer.h"

@implementation NVMaskCollectionItemView {
    NSBox *maskBox;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVMaskCollectionItemView *view = [super initWithCoder: coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    view.fillColor = [NSColor whiteColor];
    for (NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"MaskBox"]) {
            maskBox = v;
            maskBox.borderWidth = 0;
            maskBox.wantsLayer = YES;
        }
    }
    return view;
}

- (void)drawRect:(NSRect) dirtyRect {
    [super drawRect:dirtyRect];
}

-(void)setSpec:(NVMaskSpec) newSpec{
    _spec = newSpec;
    [self drawStyle];
}

- (void)drawStyle {
    [super drawStyle];
    maskBox.layer.sublayers = @[];
    if (_spec.color == nil) {
        return;
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = maskBox.bounds;
    gradient.cornerRadius = 3;
    if ([_spec.direction isEqual: @"bottom"]) {
        gradient.colors = @[
            (id)[NSColorFromRGBString(_spec.color) colorWithAlphaComponent:_spec.startOpacity].CGColor,
            (id)[[NSColor clearColor] colorWithAlphaComponent:_spec.endOpacity ].CGColor
        ];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
//        gradient.locations = @[[NSNumber numberWithFloat:0.0f],
//                                    [NSNumber numberWithFloat:1.0f]];
    } else {
        gradient.colors = @[
            (id)[[NSColor clearColor] colorWithAlphaComponent:_spec.endOpacity].CGColor,
            (id)[NSColorFromRGBString(_spec.color) colorWithAlphaComponent:_spec.startOpacity].CGColor
        ];
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(0, 0);
//        gradient.locations = @[[NSNumber numberWithFloat:0.0f],
//                                    [NSNumber numberWithFloat:1.0f]];
    }

    [maskBox.layer addSublayer:gradient];

}

@end
