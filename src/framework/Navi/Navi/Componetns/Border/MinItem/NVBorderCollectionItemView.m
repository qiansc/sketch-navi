//
//  NVBorderCollectionItemView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVBorderCollectionItemView.h"

@implementation NVBorderCollectionItemView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = true;
    self.layer.backgroundColor = [NSColor greenColor].CGColor;
    // Drawing code here.
}

-(void)setSpec:(NVBorderSpec)borderSpec{
    _spec = borderSpec;
    [self drawStyle];
    self.fillColor  = [NSColor whiteColor];
//    descText.stringValue = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
//    cb0.fillColor = NSColorFromRGBString(self.spec.defaultColor);
//    cb1.fillColor = NSColorFromRGBString(self.spec.darkColor);
//    cb2.fillColor = NSColorFromRGBString(self.spec.nightColor);
//    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.code, self.spec.cclass];
}

@end
