//
//  NVBorderCollectionItemView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVBorderSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVBorderCollectionItemView : NVToggleBox

@property (nonatomic) NVBorderSpec spec;

@end

NS_ASSUME_NONNULL_END
