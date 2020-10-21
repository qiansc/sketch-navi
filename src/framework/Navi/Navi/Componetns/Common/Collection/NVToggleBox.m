//
//  NVCollectionItem.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVToggleBox.h"

@implementation NVToggleBox {
    NSTrackingArea* trackingArea;
    NSMutableArray<NVCollectionItemCallback>* enterCbs;
    NSMutableArray<NVCollectionItemCallback>* exitCbs;
    NSMutableArray<NVCollectionItemCallback>* downCbs;
    NSMutableArray<NVCollectionItemCallback>* upCbs;
}
- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
    [super viewWillMoveToWindow:newWindow];
    [self drawStyle];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

-(void)onMouseEntered:(NVCollectionItemCallback) callback {
    if (enterCbs == nil) enterCbs = [NSMutableArray new];
    [enterCbs addObject:callback];
}
-(void)onMouseExited:(NVCollectionItemCallback) callback {
    if (exitCbs == nil) exitCbs = [NSMutableArray new];
    [exitCbs addObject:callback];
}
-(void)onMouseDown:(NVCollectionItemCallback) callback {
    if (downCbs == nil) downCbs = [NSMutableArray new];
    [downCbs addObject:callback];
}
-(void)oMouseUp:(NVCollectionItemCallback) callback {
    if (upCbs == nil) upCbs = [NSMutableArray new];
    [upCbs addObject:callback];
}

- (void)mouseEntered:(NSEvent *)event {
    [self setActived];
    for(NVCollectionItemCallback cb in enterCbs) {
        cb(event, self);
    }
}

- (void)mouseExited:(NSEvent *)event {
    [self setUnActived];
    for(NVCollectionItemCallback cb in exitCbs) {
        cb(event, self);
    }
}

- (void)mouseDown:(NSEvent *)event {
    [self setSelected];
    for(NVCollectionItemCallback cb in downCbs) {
        cb(event, self);
    }
}

- (void)mouseUp:(NSEvent *)event {
    for(NVCollectionItemCallback cb in upCbs) {
        cb(event, self);
    }
}

// 用于追踪mouseEntered / mouseExited
- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if(trackingArea) {
        [self removeTrackingArea:trackingArea];
        trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
    
    [self addTrackingArea:trackingArea];
}


- (void)setBased{
    self.isSelected = NO;
    self.isHover = NO;
    [self drawStyle];
}
- (void)setActived{
    self.isHover = YES;
    [self drawStyle];
}
- (void)setUnActived{
    self.isHover = NO;
    [self drawStyle];
}
- (void)setSelected{
    self.isSelected = YES;
    [self drawStyle];
}

- (void)drawStyle {
    if (self.isSelected) {
        self.borderColor = [NSColor controlAccentColor];
    } else if (self.isHover) {
        self.borderColor = [NSColor disabledControlTextColor];
    } else {
        self.borderColor = [NSColor disabledControlTextColor];
    }
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
