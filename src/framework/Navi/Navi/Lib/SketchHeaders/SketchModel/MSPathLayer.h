//
//  MSPathLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSLayerProtocol.h"

@protocol MSPathLayer <MSLayerProtocol>
@property(copy, nonatomic) MSPath *pathInFrame;
@property(nonatomic) BOOL edited;
@property(nonatomic) BOOL isClosed;
- (void)reversePath;
- (void)simplify;
@end
