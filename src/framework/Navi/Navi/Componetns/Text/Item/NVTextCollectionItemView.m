//
//  NVTextCollectionItemView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVTextCollectionItemView.h"
#import "HexColor.h"

@implementation NVTextCollectionItemView {
    NSBox *cb0;
    NSBox *cb1;
    NSBox *cb2;
    NSTextField *descText;
    // NSTextField *specText;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVTextCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    //    view.alphaValue = 1;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"cb0"]) cb0 = v;
        if ([v.identifier isEqual:@"cb1"]) cb1 = v;
        if ([v.identifier isEqual:@"cb2"]) cb2 = v;
        if ([v.identifier isEqual:@"descText"]) descText = v;
        // if ([v.identifier isEqual:@"specText"]) specText = v;
    }
    [self setCBorder:cb0];
    [self setCBorder:cb1];
    [self setCBorder:cb2];
    return view;
}

-(void)setCBorder:(NSBox*) box {
    box.frame = NSMakeRect(box.frame.origin.x, box.frame.origin.y, 20, 20);
    //    box.boxType = NSLineBorder;
    box.borderWidth = 1;
    box.cornerRadius = 3;
    box.wantsLayer = true;
    box.borderColor = [NSColor disabledControlTextColor];
}

-(void)setSpec:(NVTextSpec)colorSpec{
    _spec = colorSpec;
    [self drawStyle];
    descText.stringValue = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
    // specText.stringValue = self.spec.specCode;
    self.fillColor  = [NSColor whiteColor];
    cb0.fillColor = NSColorFromRGBString(self.spec.defaultColor);
    cb1.fillColor = NSColorFromRGBString(self.spec.darkColor);
    cb2.fillColor = NSColorFromRGBString(self.spec.nightColor);
    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.code, self.spec.cclass];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        descText.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        descText.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        descText.textColor = [NSColor secondaryLabelColor];
    }
}


@end
