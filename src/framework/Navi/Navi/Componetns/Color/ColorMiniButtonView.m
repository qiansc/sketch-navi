//
//  ColorMiniButtonView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorMiniButtonView.h"
#import "HexColor.h"


@interface ColorMiniButtonView()

@property (nonatomic, strong) NSTrackingArea *trackingArea;
@property (nonatomic, assign) BOOL hover;

@end

@implementation ColorMiniButtonView

// 脚本初始化调用
- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

// xib界面拖入初始化调用
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (void)commonInitialize {
    self.selected = false;
    [self setButtonType:NSButtonTypeMomentaryPushIn];
    [self setBezelStyle:NSBezelStyleRegularSquare];
}

// 重绘方法
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    [self updateState];

}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.hover = YES;
    [self updateState];
    
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.hover = NO;
    [self updateState];
};

- (void)mouseDown:(NSEvent *)event {

}

- (void)mouseUp:(NSEvent *)event {
    self.selected = YES;
    [self updateState];
//    NSLog(@"NAVIL MOSEUP IN BUTTON %@", self);
    if (self.delegate) {
        [self.delegate mouseUp:event on: self];
    }
    // NSLog(@"NAVIL BGCOLOR%@", self.layer.backgroundColor);
}

// 用于追踪mouseEntered / mouseExited
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

- (void)updateState {
    if (self.selected) {
        self.layer.borderColor =  NSColorFromRGB(0x444444).CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 2.0f;
    } else {
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 8.0f;
        if (self.hover) {
            self.layer.borderColor =  NSColorFromRGB(0x999999).CGColor;
        } else {
            self.layer.borderColor =  NSColorFromRGB(0xDDDEDD).CGColor;
        }
    }
    if (self.colorString) {
        self.layer.backgroundColor = NSColorFromRGBString(self.colorString).CGColor;
    }
}

@end
