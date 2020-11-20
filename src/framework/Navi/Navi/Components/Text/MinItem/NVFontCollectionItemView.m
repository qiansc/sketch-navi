//
//  NVFontCollectionItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVFontCollectionItemView.h"
#import "HexColor.h"

@implementation NVFontCollectionItemView {
    NSTextField *itemTitle;
    NSTextField *itemDesc;
    NSLayoutConstraint *cons;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVFontCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"ItemTitle"]) itemTitle = v;
        if ([v.identifier isEqual:@"ItemDesc"]) itemDesc = v;
    }
    return view;
}

-(void)setSpec:(NVTextSpec)fontSpec{
    _spec = fontSpec;
    [self drawStyle];
    
    double size = 48/3;
    if (_spec.iosFontSize > 78) {
        size = 65/3;
    }
    
    itemTitle.stringValue = [NSString stringWithFormat:@"无极%ipx", (int)self.spec.iosFontSize];
    [itemTitle setFont:[NSFont systemFontOfSize:size]];
    itemTitle.textColor = NSColorFromRGBString(self.spec.defaultColor);
    itemDesc.stringValue = [NSString stringWithFormat:@"%@", self.spec.cmeaning];
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
    [self removeConstraint:cons];
    cons = [self.heightAnchor constraintEqualToConstant: size + 30];
    [self addConstraint:cons];
}


-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        // itemTitle.textColor = [NSColor controlAccentColor];
        itemDesc.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        // itemTitle.textColor = [NSColor secondaryLabelColor];
        itemDesc.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        // itemTitle.textColor = [NSColor secondaryLabelColor];
        itemDesc.textColor = [NSColor secondaryLabelColor];
    }
}

@end
