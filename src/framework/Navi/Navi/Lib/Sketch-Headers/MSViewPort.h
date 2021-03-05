//
//  MSViewPort.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSDocumentAction.h"

@class MSViewPort;

@interface MSPreviewAtActualSizeAction : MSDocumentAction
{
    MSViewPort *_viewPortBeforeZoomOut;
}

- (id)label;
- (void)keyUp:(id)arg1;
- (void)doPerformAction:(id)arg1;

@end
