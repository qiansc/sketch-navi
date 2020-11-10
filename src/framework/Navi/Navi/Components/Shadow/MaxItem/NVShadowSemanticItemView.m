//
//  NVShadowSemanticItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVShadowSemanticItemView.h"
#import "HexColor.h"

@implementation NVShadowSemanticItemView {
    NSBox *box;
    NSTextField *itemTitle;
    NSTextField *itemValue;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVShadowSemanticItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    view.fillColor = [NSColor whiteColor];
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"ShadowBox"]) {
            box = v;
            box.borderWidth = 0;
            box.wantsLayer = YES;
        }
        if ([v.identifier isEqual:@"ItemTitle"]) itemTitle = v;
//        if ([v.identifier isEqual:@"ItemValue"]) itemValue = v;
    }
    return view;
}


- (void)drawRect:(NSRect) dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)setSpec:(NVShadowSpec) newSpec {
    _spec = newSpec;
    [self drawStyle];
}

- (void)drawStyle {
    [super drawStyle];
    if (_spec.color == nil) {
        return;
    }
    box.layer.shadowOffset = CGSizeMake(_spec.x, _spec.y);
    box.layer.shadowColor = NSColorFromRGBString(_spec.color).CGColor;
    box.layer.shadowOpacity = _spec.opacity;
    box.layer.shadowRadius = _spec.size;
    box.layer.masksToBounds = NO;
    box.fillColor = [NSColor whiteColor];
    itemTitle.stringValue = [NSString stringWithFormat:@"%@", self.spec.cmeaning];
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
}

@end
