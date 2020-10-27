//
//  NVTextCollectionItemView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVTextSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVTextCollectionItemView : NVToggleBox

@property (nonatomic) NVTextSpec spec;

@end

NS_ASSUME_NONNULL_END
