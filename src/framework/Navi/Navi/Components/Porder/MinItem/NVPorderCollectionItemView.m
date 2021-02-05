//
//  NVPorderCollectionItemView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPorderCollectionItemView.h"
#import "NVUserData.h"

@implementation NVPorderCollectionItemView {
    NSBox *box;
    NSTextField *textField;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVPorderCollectionItemView *view = [super initWithCoder:coder];
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
        if ([v.identifier isEqual:@"ItemTitle"]) textField = v;
    }
    box.fillColor = [NSColor systemGrayColor];
    box.borderWidth = 0;
    return view;
}

-(void)setSpec:(NVPorderSpec)borderSpec{
    _spec = borderSpec;
    [self drawStyle];
    NSDictionary *data = [NVUserData userData];
    textField.stringValue = [NSString stringWithFormat:@"%@ %@", [self dev: borderSpec], data[@"unit"]];
    box.cornerRadius = 0;
    NSArray<NSString*> *arr = [[self dev: borderSpec] componentsSeparatedByString:@","];
    if (arr[0]) {
        double num = [arr[0] doubleValue];
        if (num == -1) box.cornerRadius = 15;
        else if (num < 8) {
            box.cornerRadius = num;
        } else{
           box.cornerRadius = MIN((num-8)/3 + 8, 15);
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


-(NSString*)dev:(NVPorderSpec) spec{
    NSDictionary *data = [NVUserData userData];
    if ([data[@"unit"] isEqual:@"pt"]) {
        return spec.ios;
    } else if ([data[@"unit"] isEqual:@"dp"]) {
        return spec.android;
    } else {
        if([spec.h5 isEqualToString:@""]) {
            return @"0";
        }
        return spec.h5;
    }
}

@end
