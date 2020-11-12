//
//  NVAppCache.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVAppCache.h"

static NSMutableDictionary *cache;

@implementation NVAppCache

+(void)cacheApp:(id) app with:(MSDocument*) document {
    if (cache == nil) cache = [NSMutableDictionary new];
    NSString * key = [NSString stringWithFormat:@"%lu",[document hash]];
    cache[key] = app;
}
+(id)getAppWith:(MSDocument*) document {
    NSString * key = [NSString stringWithFormat:@"%lu",[document hash]];
    return cache[key];
}

@end
