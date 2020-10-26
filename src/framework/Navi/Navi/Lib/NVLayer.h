//
//  NVLayer.h
//  Navi
//
//  Created by QIANSC on 2020/10/25.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "MSLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVLayer : NSObject

+ (NSMutableDictionary*) fromLayer: (MSLayer*) layer;
+ (NSMutableDictionary*) initWithInfo;

+(NSArray<NSString *>*)getFillsColorCodeIn:(MSLayer*)layer;
+(NSArray<NSString *>*)getBordersColorCodeIn:(MSLayer*)layer;
+(void)set:(MSLayer*)layer fillColorCode:(NSString *) colorCode at:(NSInteger) index;
+(void)set:(MSLayer*)layer borderColorCode:(NSString *) colorCode at:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
