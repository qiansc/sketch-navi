//
//  NVLineCollectionItemView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineCollectionItemView.h"


@implementation NVLineCollectionItemView {
    NSBox *frontBox;
    NSTextField *textField;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVLineCollectionItemView *view = [super initWithCoder:coder];
    view.boxType = NSBoxCustom;
    view.borderColor = [NSColor systemGrayColor];
    view.borderType = NSLineBorder;
    view.borderWidth = 1;
    view.cornerRadius = 3;
    for(NSView *v in view.subviews) {
        if ([v.identifier isEqual:@"FrontBox"]) frontBox = v;
        if ([v.identifier isEqual:@"ItemTitle"]) textField = v;
    }
    return view;
}

-(void)drawStyle {
    [super drawStyle];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
