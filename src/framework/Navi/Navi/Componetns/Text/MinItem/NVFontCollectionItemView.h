//
//  NVFontCollectionItemView.h
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVTextSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVFontCollectionItemView : NVToggleBox

@property (nonatomic) NVTextSpec spec;

@end

NS_ASSUME_NONNULL_END
