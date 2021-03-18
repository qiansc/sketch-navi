//
//  NVLayerDelegate.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/15.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CALayer.h>
#import "MSCanvasView.h"


@interface NVLayerDelegate : NSObject<CALayerDelegate>
- (instancetype)init:(id<CALayerDelegate>) canvasView;
@end
