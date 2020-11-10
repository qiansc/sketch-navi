//
//  NVGridCollectionItemView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVGridSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVGridCollectionItemView : NVToggleBox

@property (nonatomic) NVGridSpec spec;

@end

NS_ASSUME_NONNULL_END
