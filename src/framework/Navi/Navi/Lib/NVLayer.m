//
//  NVLayer.m
//  Navi
//
//  Created by QIANSC on 2020/10/25.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLayer.h"
#import "NVLayer.h"

@implementation NVLayer {
    MSLayer *l;
}


+ (NSMutableDictionary*) fromLayer: (MSLayer*) layer{
        if (layer.userInfo == nil) {
            return [NVLayer initWithInfo];
        } if ([layer.userInfo isKindOfClass:[NSDictionary class]]){
            if (layer.userInfo[@"Navi"]) {
                return [((NSDictionary*)layer.userInfo[@"Navi"]) mutableCopy];
            }
        }
        return [NVLayer initWithInfo];
}

+(void)save:(NSMutableDictionary*) nvlayer to:(MSLayer*)layer {
    if (layer.userInfo == nil) {
        
    } if ([layer.userInfo isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *n = [layer.userInfo mutableCopy];
        n[@"Navi"] = nvlayer;
        layer.userInfo = n;
        return;
    }
    layer.userInfo = @{@"Navi": nvlayer};
}



+ (NSMutableDictionary*) initWithInfo {
    NSMutableDictionary *layer = [NSMutableDictionary new];
    layer[@"style"] = [NSMutableDictionary new];
    layer[@"style"][@"fills"] = [NSMutableArray new];
    layer[@"style"][@"borders"] = [NSMutableArray new];
    return layer;
}


+(NSArray<NSString *>*)getFillsColorCodeIn:(MSLayer*)layer {
    NSDictionary *nlayer = [NVLayer fromLayer:layer];
    NSMutableArray *arr = [NSMutableArray new];
    for(NSDictionary* d in nlayer[@"style"][@"fills"]) {
        if (d[@"colorCode"]) {
            [arr addObject:d[@"colorCode"]];
        }
    }
    return arr;
}
+(NSArray<NSString *>*)getBordersColorCodeIn:(MSLayer*)layer {
    NSDictionary *nlayer = [NVLayer fromLayer:layer];
    NSMutableArray *arr = [NSMutableArray new];
    for(NSDictionary* d in nlayer[@"style"][@"borders"]) {
        if (d[@"colorCode"]) {
            [arr addObject:d[@"colorCode"]];
        }
    }
    return arr;
}


+(void)set:(MSLayer*)layer fillColorCode:(NSString *) colorCode at:(NSInteger) index{
    NSMutableDictionary *nlayer = [NVLayer fromLayer:layer];
    NSMutableArray* fills = nlayer[@"style"][@"fills"];
    if ([fills count]>index) {
        NSMutableDictionary *fill = [fills[index] mutableCopy]; // 很关键！！
        fill[@"colorCode"] = colorCode;
        fills[index] = fill;
    } else {
        [fills addObject:@{@"colorCode": colorCode}];
    }
    [NVLayer save:nlayer to:layer];
}
+(void)set:(MSLayer*)layer borderColorCode:(NSString *) colorCode at:(NSInteger) index{
    NSMutableDictionary *nlayer = [NVLayer fromLayer:layer];
    NSMutableArray* fills = nlayer[@"style"][@"borders"];
    if ([fills count]>index) {
        NSMutableDictionary *fill = [fills[index] mutableCopy]; // 很关键！！
        fill[@"colorCode"] = colorCode;
        fills[index] = fill;
    } else {
        [fills addObject:@{@"colorCode": colorCode}];
    }
    [NVLayer save:nlayer to:layer];
}

@end
