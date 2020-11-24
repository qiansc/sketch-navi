//
//  NVVertSemanticItemView.h
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVVertSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVVertSemanticItemView : NVToggleBox

@property (nonatomic) NVVertSpec spec;

@end

NS_ASSUME_NONNULL_END
