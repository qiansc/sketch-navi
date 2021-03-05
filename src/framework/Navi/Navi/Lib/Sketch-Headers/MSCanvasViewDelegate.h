//
//  MSCanvasViewDelegate.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@protocol MSCanvasViewDelegate <NSObject>
@property(nonatomic) double zoomValue;
@property(nonatomic) struct CGPoint scrollOrigin;
- (void)canvasViewDidChangeEffectiveAppearance:(id *)arg1;
@end
