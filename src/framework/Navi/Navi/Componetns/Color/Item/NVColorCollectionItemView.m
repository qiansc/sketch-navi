//
//  NVColorCollectionItemView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorCollectionItemView.h"
#import "HexColor.h"

@implementation NVColorCollectionItemView {
    NSBox *frontBox;
    NSTextField *textFiled;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVColorCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
//    view.alphaValue = 1;
    view.borderColor = [NSColor systemGrayColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"FrontBox"]) frontBox = v;
        if ([v.identifier isEqual:@"ItemTitle"]) textFiled = v;
    }
    return view;
}

-(void)setSpec:(NVColorSpec)colorSpec{
    _spec = colorSpec;
    [self drawStyle];
    textFiled.stringValue = self.spec.specCode;
    frontBox.fillColor = NSColorFromRGBString(self.spec.hex);
}

- (void)drawRect:(NSRect)dirtyRect {
      [super drawRect:dirtyRect];
}

-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        [frontBox setTransparent:NO];
        self.fillColor  = [NSColor clearColor];
    } else if (self.isHover) {
        [frontBox setTransparent:NO];
        self.fillColor  = [NSColor clearColor];
    } else {
        [frontBox setTransparent:YES];
        self.fillColor  = NSColorFromRGBString(self.spec.hex);
    }
    
}

@end
