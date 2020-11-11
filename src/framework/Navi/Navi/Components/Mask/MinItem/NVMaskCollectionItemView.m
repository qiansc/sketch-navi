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
    if (_spec.from == nil || _spec.stops.count == 0) {
        return;
    }

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = maskBox.bounds;
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
    [maskBox.layer addSublayer:gradient];

    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
}

@end
