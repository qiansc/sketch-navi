//
//  NVShadowCollectionItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVShadowCollectionItemView.h"
#import "HexColor.h"


@implementation NVShadowCollectionItemView {
    NSBox *shadowBox;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVShadowCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    view.fillColor = [NSColor whiteColor];
    for (NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"ShadowBox"]) {
            shadowBox = v;
            shadowBox.borderWidth = 0;
            shadowBox.wantsLayer = YES;
        }
    }
    return view;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)setSpec:(NVShadowSpec) newSpec {
    _spec = newSpec;
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code , self.spec.cmeaning];
    [self drawStyle];
}

- (void)drawStyle {
    [super drawStyle];
    if (_spec.color == nil) {
        return;
    }
    shadowBox.layer.shadowOffset = CGSizeMake(_spec.x, _spec.y);
//    shadowBox.layer.shadowColor = [NSColor redColor].CGColor;
    shadowBox.layer.shadowColor = NSColorFromRGBString(_spec.color).CGColor;
    shadowBox.layer.shadowOpacity = _spec.opacity;
    shadowBox.layer.shadowRadius = _spec.size;
    shadowBox.layer.masksToBounds = NO;
    shadowBox.fillColor = [NSColor whiteColor];
}

@end
