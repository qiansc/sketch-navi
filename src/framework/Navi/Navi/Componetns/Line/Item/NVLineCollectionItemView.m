//
//  NVLineCollectionItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineCollectionItemView.h"


@implementation NVLineCollectionItemView {
    NSBox *lineBox;
    NSTextField *textField;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVLineCollectionItemView *view = [super initWithCoder:coder];
    view.fillColor = [NSColor blackColor];
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"LineBox"]) {
            lineBox = v;
        }
        if ([v.identifier isEqual:@"ItemTitle"]) textField = v;
    }
    return view;
}

- (void)setSpec:(NVLineSpec) lineSpec {
    _spec = lineSpec;
    [self drawStyle];
    textField.stringValue = self.spec.specCode;
    lineBox.fillColor = [NSColor blackColor];
    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.specCode, self.spec.desc];
}

-(void)drawStyle {
    [super drawStyle];
    self.lineHeight = (NSNumber *) self.spec.weight;
    if (self.isSelected || self.isHover) {
        [lineBox setTransparent:NO];
//        self.fillColor  = [NSColor clearColor];
    } else {
        [lineBox setTransparent:YES];
//        self.fillColor  = NSColorFromRGBString(self.spec.hex);
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
