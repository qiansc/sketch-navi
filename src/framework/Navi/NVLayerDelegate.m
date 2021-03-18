//
//  NVLayerDelegate.m
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/15.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "NVLayerDelegate.h"

@implementation NVLayerDelegate{
    id<CALayerDelegate> delegate;
}
- (instancetype)init:(id<CALayerDelegate>) canvasView
{
    self = [super init];
    if (self) {
        delegate = canvasView;
    }
    return self;
}
- (void)displayLayer:(CALayer *)layer {
    NSLog(@"### DDDD0  displayLayer: %@", layer);
    [delegate displayLayer: layer];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"### DDDD1  drawLayer: %@ ctx: %@", layer, ctx);
    [delegate drawLayer:layer inContext:ctx];
}


- (void)layerWillDraw:(CALayer *)layer {
    NSLog(@"### DDDD2  layerWillDraw: %@", layer);
    [delegate layerWillDraw: layer];
}


- (void)layoutSublayersOfLayer:(CALayer *)layer {
    NSLog(@"### DDDD3  layoutSublayersOfLayer: %@ || %@", layer, delegate);
    [delegate layoutSublayersOfLayer:layer];

}


- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    NSLog(@"### DDDD4  actionForLayer: %@ forKey: %@", layer, event);
    return [delegate actionForLayer:layer forKey:event];
}

@end
