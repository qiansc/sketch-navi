//
//  NVUserInfo.h
//  Navi
//
//  Created by QIANSC on 2020/11/4.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "MSLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVUserInfo : NSObject

@property (nonatomic, strong) NSMutableDictionary *data;

+(instancetype)fromLayer:(MSLayer*) layer;
-(void)save;

#pragma mark Text
@property (nonatomic, strong) NSString *textCode;

@end

NS_ASSUME_NONNULL_END
