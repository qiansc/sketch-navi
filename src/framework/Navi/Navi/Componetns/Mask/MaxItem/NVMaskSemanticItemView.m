//
//  NVMaskSemanticItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMaskSemanticItemView.h"
#import "HexColor.h"
#import "QuartzCore/CAGradientLayer.h"

@implementation NVMaskSemanticItemView {
    NSBox *box;
    NSTextField *itemTitle;
    NSTextField *itemValue;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVMaskSemanticItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    view.fillColor = [NSColor whiteColor];
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"MaskBox"]) {
            box = v;
            box.wantsLayer = YES;
            box.layer.sublayers = @[];
            box.borderWidth = 0;
            box.boxType = NSBoxCustom;
            box.borderType = NSLineBorder;
        }
        if ([v.identifier isEqual:@"ItemTitle"]) itemTitle = v;
//        if ([v.identifier isEqual:@"ItemValue"]) itemValue = v;
    }
    return view;
}

- (void)setSpec:(NVMaskSpec)maskSpec{
    _spec = maskSpec;
    [self drawStyle];
}

- (void)drawRect:(NSRect) dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)drawStyle {
    [super drawStyle];
    box.layer.sublayers = @[];
    box.fillColor = [NSColor clearColor];
    if (_spec.color == nil) {
        return;
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = box.bounds;
    gradient.cornerRadius = 3;
    if ([_spec.direction isEqual: @"bottom"]) {
        gradient.colors = @[
            (id)[NSColorFromRGBString(_spec.color) colorWithAlphaComponent:_spec.startOpacity].CGColor,
            (id)[[NSColor clearColor] colorWithAlphaComponent:_spec.endOpacity ].CGColor
        ];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
    } else {
        gradient.colors = @[
            (id)[[NSColor clearColor] colorWithAlphaComponent:_spec.endOpacity].CGColor,
            (id)[NSColorFromRGBString(_spec.color) colorWithAlphaComponent:_spec.startOpacity].CGColor
        ];
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(0, 0);
    }
    [box.layer addSublayer:gradient];

    itemTitle.stringValue = [NSString stringWithFormat:@"%@", self.spec.cmeaning];
//        box.cornerRadius = 0;
    //    NSArray<NSString*> *arr = [maskSpec.ios componentsSeparatedByString:@","];
    //    itemValue.stringValue = @"";
    //    if (arr[0]) {
    //        double num = [arr[0] doubleValue];
    //        if (num == -1) {
    //            box.cornerRadius = 10;
    //            itemValue.stringValue = @"MAX";
    //        } else {
    //            box.cornerRadius = MIN(num / 2, 10);
    //            itemValue.stringValue = arr[0];
    //        }
    //
    //
    //    }


    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
}

@end
