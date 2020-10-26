//
//  NVLineSource.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineSource.h"

@implementation NVLineSource {
    NVSourceUpdateCallback updatedCallback;
    NSString *searchQuery;
    NSMutableDictionary *dims;
}

- (void)update:(NSArray<NSDictionary*> *) specs {
    dims = [NSMutableDictionary new];
    for(NSDictionary* spec in specs) {
        NSArray *dimArr = spec[@"dim"];
        if ([dimArr count]) {
            NSString *dim = dimArr[0];
            dims[dim] = dims[dim] == nil ? [NSMutableArray new] : dims[dim];
            [dims[dim] addObject: spec];
        }
    }
    updatedCallback();
}

- (void)onUpdated:(NVSourceUpdateCallback) callback {
    updatedCallback = callback;
}

- (void)setQuery:(NSString *) query {
    searchQuery = query;
    updatedCallback();
}

- (NSArray<NSString*>*)getDims {
    return [dims allKeys];
}

- (NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim {
    return dims[dim];
}

- (NSArray<NSDictionary*>*)getSpecsIn:(long) section{
    NSString *dim = [self getDims][section];
    return dims[dim];
}

- (NVLineSpec)getSpecAt:(NSIndexPath *) indexPath {
    NSDictionary *dict = [self getSpecsIn:indexPath.section][indexPath.item];
    return [NVLineSource value: dict];
}

+ (NVLineSpec)value:(NSDictionary*) specDict {
    NVLineSpec spec = {
        .weight = specDict[@"weight"],
        .specCode = specDict[@"specCode"],
        .desc = specDict[@"desc"],
        .text = specDict[@"text"],
    };
    return spec;
}

@end
