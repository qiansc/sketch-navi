//
//  NVPorderSemanticItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPorderSemanticItemView.h"
#import "NVUserData.h"

@implementation NVPorderSemanticItemView{
    NSBox *box;
    NSTextField *itemText;
    NSTextField *itemValue;

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVPorderSemanticItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"borderBox"]) {
            box = v;
        }
        if ([v.identifier isEqual:@"ItemTitle"]) itemText = v;
        if ([v.identifier isEqual:@"ItemValue"]) itemValue = v;
    }
    box.fillColor = [NSColor systemGrayColor];
    box.borderWidth = 0;
    return view;
}

-(void)setSpec:(NVPorderSpec)borderSpec{
    _spec = borderSpec;
    [self drawStyle];
    itemText.stringValue = [NSString stringWithFormat:@"%@  %@", self.spec.code, self.spec.cmeaning];
    box.cornerRadius = 0;
    NSArray<NSString*> *arr = [[self dev: borderSpec] componentsSeparatedByString:@","];
    itemValue.stringValue = @"";
    if (arr[0]) {
        double num = [arr[0] doubleValue];
        if (num == -1) {
            box.cornerRadius = 10;
            itemValue.stringValue = @"全圆";
        } else {
            box.cornerRadius = MIN(num / 2, 10);
            itemValue.stringValue = @"";
        }


    }
    box.boxType = NSBoxCustom;
    box.borderType = NSLineBorder;
    box.wantsLayer = true;
    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];

}


-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        itemText.textColor = [NSColor controlAccentColor];
        itemValue.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        itemText.textColor = [NSColor secondaryLabelColor];
        itemValue.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        itemText.textColor = [NSColor secondaryLabelColor];
        itemValue.textColor = [NSColor secondaryLabelColor];
    }
}

-(NSString*)dev:(NVPorderSpec) spec{
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
