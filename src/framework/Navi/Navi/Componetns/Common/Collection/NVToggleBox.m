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
    for(NVCollectionItemCallback cb in enterCbs) {
        cb(event);
    }
}

- (void)mouseExited:(NSEvent *)event {
    for(NVCollectionItemCallback cb in exitCbs) {
        cb(event);
    }
}

- (void)mouseDown:(NSEvent *)event {
    for(NVCollectionItemCallback cb in downCbs) {
        cb(event);
    }
}

- (void)mouseUp:(NSEvent *)event {
    for(NVCollectionItemCallback cb in upCbs) {
        cb(event);
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

@end
