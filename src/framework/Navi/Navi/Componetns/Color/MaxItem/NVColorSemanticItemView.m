//
//  NVColorSemanticItemView.m
//  Navi
//
//  Created by QIANSC on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorSemanticItemView.h"
#import "HexColor.h"

@implementation NVColorSemanticItemView {
    NSBox *cb0;
    NSBox *cb1;
    NSBox *cb2;
    NSTextField *descText;
    // NSTextField *specText;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVColorSemanticItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    //    view.alphaValue = 1;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    NSLog(@"NAVIL HEREHRHER");
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

-(void)setSpec:(NVColorSpec)colorSpec{
    NSLog(@"NAVIL colorSpeccolorSpeccolorSpec %@", colorSpec.specCode);
    _spec = colorSpec;
    [self drawStyle];
    descText.stringValue = self.spec.desc;
    // specText.stringValue = self.spec.specCode;
    self.fillColor  = [NSColor whiteColor];
    cb0.fillColor = NSColorFromRGBString(self.spec.hex);
    cb1.fillColor = NSColorFromRGBString(self.spec.hex1);
    cb2.fillColor = NSColorFromRGBString(self.spec.hex2);
    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.specCode, self.spec.desc];
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
