//
//  NVLineSource.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <NVSource.h>

NS_ASSUME_NONNULL_BEGIN

struct NVLineSpec {
    NSString *weight; // 线条粗细
    NSString *specCode; // 编码
    NSString *desc; // 语义化
    NSString *text; // 显示的文字
};

typedef struct NVLineSpec NVLineSpec;


@interface NVLineSource : NSObject<NVSource>

@property (nonatomic) BOOL semanticMode;

- (NSArray<NSString*>*)getDims;
- (NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
- (NSArray<NSDictionary*>*)getSpecsIn:(long) section;
- (NVLineSpec)getSpecAt:(NSIndexPath *) indexPath;

+ (NVLineSpec)value:(NSDictionary*) specDict;

@end

NS_ASSUME_NONNULL_END
