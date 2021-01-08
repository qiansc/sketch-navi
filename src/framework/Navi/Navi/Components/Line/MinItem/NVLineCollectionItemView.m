//
//  NVLineCollectionItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineCollectionItemView.h"
#import "NVUserData.h"


@implementation NVLineCollectionItemView {
    NSBox *lineBox;
    NSTextField *textField;
    NSLayoutConstraint* constraintHeight;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVLineCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    view.fillColor = [NSColor whiteColor];
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"LineBox"]) {
            lineBox = v;
            lineBox.fillColor = [NSColor systemGrayColor];
            lineBox.borderWidth = 0;
            lineBox.cornerRadius = 0;
        }
        if ([v.identifier isEqual:@"ItemTitle"]) textField = v;
    }
    return view;
}

- (void)setSpec:(NVLineSpec) lineSpec {
    [lineBox removeConstraint: constraintHeight];
    _spec = lineSpec;
    [self drawStyle];
    textField.stringValue = [NSString stringWithFormat:@"%.2lf", [self dev:_spec]];
    CGFloat lineHeight = [self dev:_spec];
    constraintHeight = [lineBox.heightAnchor constraintEqualToConstant: lineHeight >= 1 ? lineHeight : 1];
    [lineBox addConstraint:constraintHeight];
    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.code, self.spec.cmeaning];
}

-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        textField.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        textField.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        textField.textColor = [NSColor secondaryLabelColor];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}


-(double)dev:(NVLineSpec) spec{
    NSDictionary *data = [NVUserData userData];
    if ([data[@"unit"] isEqual:@"pt"]) {
        return spec.ios;
    } else if ([data[@"unit"] isEqual:@"dp"]) {
        return spec.android;
    } else {
        return spec.h5;
    }
}


@end
