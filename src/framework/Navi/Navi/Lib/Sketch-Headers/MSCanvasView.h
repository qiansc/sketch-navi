//
//  MSCanvasView.h
//  Navi
//
//  Created by QIANSC on 2020/11/30.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

@interface MSCanvasView : NSView

@property(retain, nonatomic) NSObject *viewPort;

- (struct CGPoint)viewCenterInAbsoluteCoordinatesForViewPort:(id)arg1;

@end
