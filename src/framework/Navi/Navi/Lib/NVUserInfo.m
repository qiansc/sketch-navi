//
//  NVUserInfo.m
//  Navi
//
//  Created by QIANSC on 2020/11/4.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVUserInfo.h"

@implementation NVUserInfo {
    MSLayer *_layer;
}

static NSMutableDictionary *cache;

+(instancetype)fromLayer:(MSLayer*) layer {
    if (cache == nil) cache = [NSMutableDictionary new];
    if (cache[layer.objectID]) {
        return cache[layer.objectID];
    }
    NVUserInfo * userInfo = [[NVUserInfo alloc] initWithLayer:layer];
    cache[layer.objectID] = userInfo;
    return userInfo;
}

-(void)save{
    NSMutableDictionary *origin;
    if (_layer.userInfo == nil) {
        origin = [NSMutableDictionary new];
    } else {
        origin = [_layer.userInfo mutableCopy];
    }
    [origin setObject:self.data forKey:@"sketch-navi"];
    _layer.userInfo = origin;
}

-(instancetype)initWithLayer:(MSLayer*) layer {
    // [super init];
    _layer = layer;
    if (layer.userInfo == nil || layer.userInfo[@"sketch-navi"] == nil) {
        self.data = [NSMutableDictionary new];
        self.data[@"style"] = [NSMutableDictionary new];
        self.data[@"style"][@"fills"] = [NSMutableArray new];
        self.data[@"style"][@"borders"] = [NSMutableArray new];
        self.data[@"textColorCode"] = @"";
        self.data[@"textCode"] = @"";
    } else {
        self.data = [layer.userInfo[@"sketch-navi"] mutableCopy];
    }
    return self;
}

#pragma mark Text

-(NSString*)textCode {
    return self.data[@"textCode"];
}
-(void)setTextCode:(NSString*)textCode {
    self.data[@"textCode"] = textCode;
    [self save];
}

//-(NSArray<NSString *>*)getTextCode{
//    NSDictionary *nlayer = [NVLayer fromLayer:layer];
//    if ([[layer className] isEqual:@"MSTextLayer"] && nlayer[@"textCode"]){
//        return @[nlayer[@"textCode"]];
//    }
//    return @[];
//}


@end
