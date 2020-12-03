//
//  NVIconSemanticItemView.m
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVIconSemanticItemView.h"
#import "HexColor.h"

@implementation NVIconSemanticItemView{
    NSTextField *itemTitle;
    NSTextField *itemDesc;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVIconSemanticItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor disabledControlTextColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    view.wantsLayer = YES;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"ItemTitle"]) itemTitle = v;
        if ([v.identifier isEqual:@"ItemDesc"]) itemDesc = v;
    }
    return view;
}

-(void)setSpec:(NVIconSpec)fontSpec{
    _spec = fontSpec;
    [self drawStyle];

//    itemTitle.stringValue = self.spec.cmeaning;
//    itemTitle.textColor = NSColorFromRGBString(self.spec.defaultColor);
//    itemDesc.stringValue = [NSString stringWithFormat:@"%i", (int)self.spec.iosFont];

    [self drawIcon: _spec.svg];

    self.toolTip = [NSString stringWithFormat:@"%@ %@", self.spec.code, self.spec.cmeaning];
}

- (void)drawIcon:(NSString *) rawSVGContent {
    SVGKImage *iconImage = [SVGLoader fromRawUTF8SVGString:rawSVGContent];
    iconImage.size = NSMakeSize(20, 20);
    self.fastImageView.frameSize = iconImage.size;
    self.fastImageView.image = iconImage;
}


-(void)drawStyle {
    [super drawStyle];
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
        itemTitle.textColor = [NSColor controlAccentColor];
        itemDesc.textColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
        itemTitle.textColor = [NSColor secondaryLabelColor];
        itemDesc.textColor = [NSColor secondaryLabelColor];
    } else {
        self.fillColor  = [NSColor controlBackgroundColor];
        self.borderColor = [NSColor windowBackgroundColor];
        itemTitle.textColor = [NSColor secondaryLabelColor];
        itemDesc.textColor = [NSColor secondaryLabelColor];
    }
}
@end
