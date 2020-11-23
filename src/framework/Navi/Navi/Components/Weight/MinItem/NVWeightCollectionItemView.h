//
//  NVWeightCollectionItemView.h
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVWeightSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVWeightCollectionItemView : NVToggleBox

@property (nonatomic) NVWeightSpec spec;

@end

NS_ASSUME_NONNULL_END
