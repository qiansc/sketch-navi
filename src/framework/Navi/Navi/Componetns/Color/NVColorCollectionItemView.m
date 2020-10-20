//
//  NVColorCollectionItemView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorCollectionItemView.h"
#import "HexColor.h"

@implementation NVColorCollectionItemView

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVColorCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
//    view.alphaValue = 1;
    view.borderColor = [NSColor systemGrayColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    return view;
}

- (void)drawRect:(NSRect)dirtyRect {
      [super drawRect:dirtyRect];
//    [self drawBorder:dirtyRect];
}

- (void)setBased{
    self.borderColor = [NSColor disabledControlTextColor];
}
- (void)setActived{
    self.borderColor = [NSColor disabledControlTextColor];
}
- (void)setSelected{
    self.borderColor = [NSColor controlAccentColor];
}

//- (void)drawBorder:(NSRect)rect {
//    NSRect frameRect = [self bounds];
//    if(rect.size.height < frameRect.size.height)
//        return;
//    NSRect newRect = NSMakeRect(rect.origin.x + 1, rect.origin.y + 1, rect.size.width-2,rect.size.height-2);
//
//    NSBezierPath *textViewSurround = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:2.5 yRadius:2.5];
//    [textViewSurround setLineWidth: 0.5];
//    [NSColorFromRGBString(@"BCBCBC") set];
//    [textViewSurround stroke];
//}

@end
