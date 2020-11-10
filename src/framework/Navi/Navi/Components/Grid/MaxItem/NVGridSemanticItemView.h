//
//  NVGridSemanticItemView.h
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVGridSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVGridSemanticItemView : NVToggleBox

@property (nonatomic) NVGridSpec spec;

@end

NS_ASSUME_NONNULL_END
