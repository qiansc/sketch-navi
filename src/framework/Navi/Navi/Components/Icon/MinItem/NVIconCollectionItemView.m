//
//  NVIconCollectionItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVIconCollectionItemView.h"
#import "HexColor.h"

@implementation NVIconCollectionItemView {
    NSTextField *itemTitle;
    NSTextField *itemDesc;
    NSLayoutConstraint *cons;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVIconCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
//        if ([v.identifier isEqual:@"ItemTitle"]) itemTitle = v;
//        if ([v.identifier isEqual:@"ItemDesc"]) itemDesc = v;
    }
    return view;
}

-(void)setSpec:(NVIconSpec)fontSpec{
    _spec = fontSpec;
    [self drawStyle];
//    itemTitle.textColor = NSColorFromRGBString(self.spec.defaultColor);
//    itemDesc.stringValue = [NSString stringWithFormat:@"%@", self.spec.cmeaning];
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
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
