//
//  MSTiledRendererHostView-Protocol.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@protocol MSTiledRendererHostView
- (struct CGPoint)convertPointFromPage:(struct CGPoint)arg1;
// - (struct CGPoint)convertPoint:(struct CGPoint)arg1 toCoordinateSpace:(id <MSLayerCoordinateSpace>)arg2;
- (void)setNeedsRenderWithMask:(unsigned long long)arg1;
//- (MSRenderingDriver *)driver;
@end
