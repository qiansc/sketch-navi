//
//  ColorCollectionItem.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorCollectionItem.h"
#import "HexColor.h"

@implementation NVColorCollectionItem {
    NVColorSpec spec;
    BOOL hover;
    BOOL selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)initWithSpec:(NVColorSpec) colorSpec {
    spec = colorSpec;
    self.textFiled.stringValue = spec.specCode;
    self.view.fillColor  = NSColorFromRGBString(spec.hex);
    self.frontBox.fillColor = NSColorFromRGBString(spec.hex);
    [self.view onMouseEntered: ^void(NSEvent *event) {
        hover = YES;
        [self updateStyle];
    }];
    [self.view onMouseExited: ^void(NSEvent *event) {
        hover = NO;
        [self updateStyle];
    }];
    [self.view onMouseDown: ^void(NSEvent *event) {
        selected = YES;
        [self updateStyle];
    }];
    [self updateStyle];
}

- (void)click:(NSButton *) button {
    NSLog(@"NAVIL LLLLLCLICK %@", button);
}

- (void)updateStyle {
    if (selected) {
        [self.view setSelected];
        [self.frontBox setTransparent:NO];
        self.view.fillColor  = [NSColor clearColor];
    } else if (hover) {
        [self.view setActived];
        [self.frontBox setTransparent:NO];
        self.view.fillColor  = [NSColor clearColor];
    } else {
        [self.view setBased];
        [self.frontBox setTransparent:YES];
        self.view.fillColor  = NSColorFromRGBString(spec.hex);
    }
}

@end
