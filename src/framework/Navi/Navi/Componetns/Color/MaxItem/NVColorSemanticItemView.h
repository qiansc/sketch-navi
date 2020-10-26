//
//  NVColorSemanticItemView.h
//  Navi
//
//  Created by QIANSC on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVToggleBox.h"
#import "NVColorSource.h"


NS_ASSUME_NONNULL_BEGIN

@interface NVColorSemanticItemView : NVToggleBox

@property (nonatomic) NVColorSpec spec;

@end

NS_ASSUME_NONNULL_END
