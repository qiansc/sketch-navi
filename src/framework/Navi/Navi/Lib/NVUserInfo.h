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
@property (nonatomic, strong) NSString *textCode; // 文本（复合）
@property (nonatomic, strong) NSString *fontCode; // 字体
@property (nonatomic, strong) NSString *fontColorCode; // 字色

#pragma mark Style-Fill
@property (nonatomic, strong) NSString *fillColorCode; // 填充

#pragma mark Style-Border
@property (nonatomic, strong) NSString *borderColorCode; // 边
@property (nonatomic, strong) NSString *borderThicknessCode; //厚度

#pragma mark Style-Shadow
@property (nonatomic, strong) NSString *shadowCode; // 阴影


#pragma mark Points - CurvePoint

@property (nonatomic, strong) NSString *cornerRadiusCode;

#pragma mark Frame

@property (nonatomic, strong) NSString *gridWidthCode;
@property (nonatomic, strong) NSString *gridScaleCode;

@property (nonatomic, strong) NSString *marginLeftCode;
@property (nonatomic, strong) NSString *marginRightCode;
@property (nonatomic, strong) NSString *marginTopCode;
@property (nonatomic, strong) NSString *marginBottomCode;

@property (nonatomic, strong) NSString *marginLeftTarget;
@property (nonatomic, strong) NSString *marginRightTarget;
@property (nonatomic, strong) NSString *marginTopTarget;
@property (nonatomic, strong) NSString *marginBottomTarget;


@end

NS_ASSUME_NONNULL_END
