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
    NSArray<NSDictionary*> *specs;
}

- (void)update:(NSArray<NSDictionary*> *) newSpecs {
    specs = newSpecs;
    dims = [NSMutableDictionary new];
    if (searchQuery.length > 0) {
        for (NSDictionary* spec in specs) {
            NSArray *dimArr = spec[@"dim"];
            if ([self filter:spec] && [dimArr count]) {
                NSString *dim = dimArr[0];
                dims[dim] = dims[dim] == nil ? [NSMutableArray new] : dims[dim];
                [dims[dim] addObject:spec];
            }
        }
    } else {
        for(NSDictionary* spec in specs) {
            NSArray *dimArr = spec[@"dim"];
            if ([dimArr count]) {
                NSString *dim = dimArr[0];
                dims[dim] = dims[dim] == nil ? [NSMutableArray new] : dims[dim];
                [dims[dim] addObject: spec];
            }
        }
    }
    updatedCallback();
}

- (BOOL)filter:(NSDictionary *) specDict {
    NVLineSpec spec = [NVLineSource value:specDict];
    return [spec.weight containsString:searchQuery] || [spec.desc containsString: searchQuery] || [spec.specCode containsString:searchQuery] || [spec.text containsString:searchQuery];
}

- (void)onUpdated:(NVSourceUpdateCallback) callback {
    updatedCallback = callback;
}

- (void)setQuery:(NSString *) query {
    searchQuery = query;
    [self update: specs];
    updatedCallback();
}

- (void)setSemanticMode:(BOOL) mode {
    _semanticMode = mode;
//    updatedCallback();
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
