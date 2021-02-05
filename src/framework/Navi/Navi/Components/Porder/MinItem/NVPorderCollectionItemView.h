//
//  NVPorderCollectionItemView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVPorderSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPorderCollectionItemView : NVToggleBox

@property (nonatomic) NVPorderSpec spec;

@end

NS_ASSUME_NONNULL_END
