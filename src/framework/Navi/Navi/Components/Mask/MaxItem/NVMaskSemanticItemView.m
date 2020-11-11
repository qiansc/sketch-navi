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
    if (_spec.from == nil || _spec.stops.count == 0) {
        return;
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = box.bounds;
    gradient.cornerRadius = 3;
    gradient.startPoint = CGPointMake(_spec.from.x, _spec.from.y);
    gradient.endPoint = CGPointMake(_spec.to.x, _spec.to.y);
    NSMutableArray *colors = [NSMutableArray new];
    NSMutableArray<NSNumber *> *locations = [NSMutableArray new];
    for (MaskStop *stop in _spec.stops) {
        NSColor *c = [NSColor colorWithRed:(stop.color.red / 255) green:(stop.color.green / 255) blue:(stop.color.blue / 255) alpha:1];
        [colors addObject:((id)c.CGColor)];
        [locations addObject:[NSNumber numberWithDouble:stop.position]];
    }
    gradient.colors = colors;
    gradient.locations = locations;
    [box.layer addSublayer:gradient];
    itemTitle.stringValue = [NSString stringWithFormat:@"%@", self.spec.cmeaning];
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
}

@end
