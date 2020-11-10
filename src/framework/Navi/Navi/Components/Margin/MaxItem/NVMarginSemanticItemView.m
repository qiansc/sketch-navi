//
//  NVMarginSemanticItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMarginSemanticItemView.h"

@implementation NVMarginSemanticItemView{
    //    NSBox *box;
    NSTextField *itemTitle;
    NSTextField *itemDesc;
    NSTextField *itemCode;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVMarginSemanticItemView *view = [super initWithCoder:coder];
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
        if ([v.identifier isEqual:@"ItemDesc"]) itemDesc = v;
        if ([v.identifier isEqual:@"ItemCode"]) itemCode = v;
    }
    //    box.fillColor = [NSColor systemGrayColor];
    //    box.borderWidth = 0;
    return view;
}

-(void)setSpec:(NVMarginSpec)borderSpec{
    _spec = borderSpec;
    [self drawStyle];
    itemTitle.stringValue = [NSString stringWithFormat:@"%@", self.spec.desc];
    itemDesc.stringValue = self.spec.cmeaning;
    itemCode.stringValue = self.spec.elementCode;
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
        itemDesc.textColor = [NSColor controlAccentColor];
        itemCode.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        itemTitle.textColor = [NSColor secondaryLabelColor];
        itemDesc.textColor = [NSColor secondaryLabelColor];
        itemCode.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        itemTitle.textColor = [NSColor secondaryLabelColor];
        itemDesc.textColor = [NSColor secondaryLabelColor];
        itemCode.textColor = [NSColor secondaryLabelColor];
    }
}
@end
