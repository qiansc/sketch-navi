//
//  NVMarginCollectionItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMarginCollectionItemView.h"

@implementation NVMarginCollectionItemView {
//    NSBox *box;
    NSTextField *itemTitle;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVMarginCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
//        if ([v.identifier isEqual:@"borderBox"]) {
//            box = v;
//        }
        if ([v.identifier isEqual:@"ItemTitle"]) itemTitle = v;
    }
//    box.fillColor = [NSColor systemGrayColor];
//    box.borderWidth = 0;
    return view;
}

-(void)setSpec:(NVMarginSpec)borderSpec{
    _spec = borderSpec;
    [self drawStyle];
    itemTitle.stringValue = [NSString stringWithFormat:@"%@", self.spec.desc];
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code , self.spec.cmeaning];
//    box.cornerRadius = 0;
//    box.boxType = NSBoxCustom;
//    box.borderType = NSLineBorder;
//    box.wantsLayer = true;
}


-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        itemTitle.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        itemTitle.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        itemTitle.textColor = [NSColor secondaryLabelColor];
    }
}

@end
