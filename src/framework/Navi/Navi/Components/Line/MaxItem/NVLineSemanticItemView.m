//
//  NVLineSemanticItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineSemanticItemView.h"

@implementation NVLineSemanticItemView {
    NSBox *lineBox;
    NSTextField *textField;
    NSTextField *valueField;
    NSLayoutConstraint* constraintHeight;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    NVLineSemanticItemView *view = [super initWithCoder:coder];
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
        if ([v.identifier isEqual:@"ItemValue"]) valueField = v;
    }
    return view;
}

- (void)setSpec:(NVLineSpec) lineSpec {
    [lineBox removeConstraint: constraintHeight];
    _spec = lineSpec;
    [self drawStyle];
    textField.stringValue = self.spec.desc;
    CGFloat lineHeight = [((NSNumber *) self.spec.weight) doubleValue];
    constraintHeight = [lineBox.heightAnchor constraintEqualToConstant: lineHeight];
    [lineBox addConstraint:constraintHeight];
    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.specCode, self.spec.desc];
    valueField.stringValue = self.spec.text;
}

-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        textField.textColor = [NSColor controlAccentColor];
        valueField.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        textField.textColor = [NSColor secondaryLabelColor];
        valueField.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        textField.textColor = [NSColor secondaryLabelColor];
        valueField.textColor = [NSColor secondaryLabelColor];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end