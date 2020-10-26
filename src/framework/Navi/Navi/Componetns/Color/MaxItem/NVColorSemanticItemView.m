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
    NSTextField *specText;
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
        if ([v.identifier isEqual:@"specText"]) specText = v;
    }
    return view;
}

-(void)setSpec:(NVColorSpec)colorSpec{
    NSLog(@"NAVIL colorSpeccolorSpeccolorSpec %@", colorSpec.specCode);
    _spec = colorSpec;
    [self drawStyle];
    descText.stringValue = self.spec.desc;
    specText.stringValue = self.spec.specCode;
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
    } else if (self.isHover) {
        self.borderColor = [NSColor systemGrayColor];
    } else {
        self.borderColor = [NSColor disabledControlTextColor];
    }
}

@end
