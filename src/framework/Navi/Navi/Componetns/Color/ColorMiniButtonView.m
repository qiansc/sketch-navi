//
//  ColorMiniButtonView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorMiniButtonView.h"
#import "../../Lib/HexColor.h"


@interface ColorMiniButtonView()

@property (nonatomic, strong) NSTrackingArea *trackingArea;
@property (nonatomic, assign) BOOL hover;

@end

@implementation ColorMiniButtonView

- (instancetype)initWithFrame:(NSRect)frameRect {
    
    self = [super initWithFrame:frameRect];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {

    self = [super initWithCoder:coder];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (void)commonInitialize {
    self.selected = false;
    self.hasBorder = false;
    self.toolTip = @"SAM_0001";
    [self setButtonType:NSButtonTypeMomentaryPushIn];
    [self setBezelStyle:NSBezelStyleRegularSquare];
}

- (void)drawRect:(NSRect)dirtyRect {
//    [[NSColor yellowColor] setFill];
//    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    self.layer.backgroundColor = [NSColor yellowColor].CGColor;
    self.layer.borderWidth = 1.0f;
    [self updateButtonState];

}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.hover = YES;
    [self updateButtonState];
    
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.hover = NO;
    [self updateButtonState];
};

- (void)mouseDown:(NSEvent *)event {
    self.selected = !self.selected;
    [self updateButtonState];
//    self.layer.backgroundColor = [NSColor redColor].CGColor;
}

- (void)mouseUp:(NSEvent *)event {
//    self.layer.backgroundColor = [NSColor yellowColor].CGColor;
}


- (void)updateTrackingAreas {
    
    [super updateTrackingAreas];
    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
    
    [self addTrackingArea:self.trackingArea];
}

- (void)updateButtonState {
    if (self.selected) {
        self.layer.borderColor =  NSColorFromRGB(0x333333).CGColor;
    } else {
        if (self.hover) {
            self.layer.borderColor =  NSColorFromRGB(0x666666).CGColor;
        } else {
            self.layer.borderColor =  NSColorFromRGB(0xDDDEDD).CGColor;
        }
    }
}

- (void)setColor:(CGColorRef)CGColor {
    
}

@end
