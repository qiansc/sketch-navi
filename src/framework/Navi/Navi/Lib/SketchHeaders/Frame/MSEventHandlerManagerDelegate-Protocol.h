//
//  MSEventHandlerManagerDelegate-Protocol.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//
#import "MSEventHandlerManager.h"
#import "MSEventHandler.h"

@protocol MSEventHandlerManagerDelegate <NSObject>
- (void)eventHandlerManager:(id)arg1 didChangeCurrentHandler:(MSEventHandler *)arg2;
@end
