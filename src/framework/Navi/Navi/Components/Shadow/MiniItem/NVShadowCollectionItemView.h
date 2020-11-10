//
//  NVShadowCollectionItemView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVShadowSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVShadowCollectionItemView : NVToggleBox

@property (nonatomic) NVShadowSpec spec;

@end

NS_ASSUME_NONNULL_END
