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
    NSTextField *cnameText;
    NSBox *infoBox;
    NSBox *line;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVColorCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
//    view.alphaValue = 1;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"FrontBox"]) frontBox = v;
        if ([v.identifier isEqual:@"CName"]) cnameText = v;
        if ([v.identifier isEqual:@"InfoBox"]) infoBox = v;
        if ([v.identifier isEqual:@"line"]) line = v;
        if ([v isKindOfClass:[NSTextField class]]) cnameText =v;
    }
    
    line.wantsLayer = true;
    line.boxType = NSBoxCustom;
    // line.fillColor = [NSColor yellowColor];
//    line.borderColor = [NSColor yellowColor];

    line.fillColor = [NSColor clearColor];
    line.borderColor = [NSColor clearColor];
    line.layer.borderColor = [NSColor clearColor].CGColor;
    line.layer.backgroundColor = [NSColor quaternaryLabelColor].CGColor;
    
    
    infoBox.wantsLayer = YES;
    infoBox.layer.borderColor = [NSColor quaternaryLabelColor].CGColor;
//    infoBox.borderType = NSLineBorder;
    infoBox.layer.borderWidth = 1;
    infoBox.layer.cornerRadius = 3;
    infoBox.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;;
    infoBox.fillColor = [NSColor controlBackgroundColor];

    

    return view;
    
}

-(void)setSpec:(NVColorSpec)colorSpec{
    _spec = colorSpec;
    [self drawStyle];
    NSLog(@"NAVIL cnameText %@ %@", cnameText, self.spec.cname);
    cnameText.stringValue = self.spec.cname;
    frontBox.fillColor = NSColorFromRGBString(self.spec.hex);
    self.toolTip = [NSString stringWithFormat:@"%@ - %@", self.spec.specCode, self.spec.desc];
    

}

- (void)drawRect:(NSRect)dirtyRect {
      [super drawRect:dirtyRect];
}

-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        [frontBox setTransparent:NO];
        self.fillColor  = [NSColor clearColor];
        infoBox.layer.borderColor = [NSColor controlAccentColor].CGColor;
        cnameText.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        [frontBox setTransparent:NO];
        self.fillColor  = [NSColor clearColor];
        self.borderColor = [NSColor quaternaryLabelColor];
        infoBox.layer.borderColor = [NSColor quaternaryLabelColor].CGColor;
        cnameText.textColor = [NSColor secondaryLabelColor];
    } else {
        [frontBox setTransparent:YES];
        self.fillColor  = NSColorFromRGBString(self.spec.hex);
        self.borderColor = [NSColor quaternaryLabelColor];
        infoBox.layer.borderColor = [NSColor quaternaryLabelColor].CGColor;
        cnameText.textColor = [NSColor secondaryLabelColor];
    }
    
}

@end
