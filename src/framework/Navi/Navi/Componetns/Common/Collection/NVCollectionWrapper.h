//
//  NVCollectionWrapper.h
//  Navi
//
//  Created by QIANSC on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DisabledWheelScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVCollectionWrapper : DisabledWheelScrollView

- (void)setHeight:(float) newHeight;

@end

NS_ASSUME_NONNULL_END
