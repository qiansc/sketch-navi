//
//  NVMaskCollectionItemView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVMaskSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVMaskCollectionItemView : NVToggleBox

@property (nonatomic) NVMaskSpec spec;

@end

NS_ASSUME_NONNULL_END
