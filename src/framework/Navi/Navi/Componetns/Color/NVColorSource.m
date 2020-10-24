//
//  ColorSpec.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorSource.h"
#import "NVSource.h"

@implementation NVColorSource {
    NVSourceUpdateCallback updatedCallback;
    NSString *searchQuery;
    NSMutableDictionary *dims;
    NSArray<NSDictionary*> *specs;
    
}

// hex: "EEEEEE", alpha: 100, specCode: "SAM_001", desc: "语义描述001",
// dim: ["背景色"], fillMode: true, borderMode: true,

-(void)update:(NSArray<NSDictionary*>*) newSpecs {
    specs = newSpecs;
    dims = [NSMutableDictionary new];
    for(NSDictionary* spec in specs) {
        NSArray *dimArr = spec[@"dim"];
         if ([self filter:spec]) {
            if ([dimArr count]) {
                NSString *dim = dimArr[0];
                dims[dim] = dims[dim] == nil ? [NSMutableArray new] : dims[dim];
                [dims[dim] addObject: spec];
                // NVColorSpec s = [NVColorSource value:spec];
                // NSLog(@"NAVIL COLORIIIIII %hhd %f %@", s.borderMode, s.alpha, s.hex);
            }
         }
    }
    updatedCallback();
}

-(BOOL)filter:(NSDictionary*) specDict {
    if (searchQuery == nil || searchQuery.length == 0) {
        return true;
//    } else if ([specDict[@"dim"] containsString:searchQuery]) {
//        return true;
    } else if ([specDict[@"desc"] containsString:searchQuery]) {
        return true;
    } else if ([specDict[@"specCode"] containsString:searchQuery]) {
        return true;
    } else if ([specDict[@"hex"] containsString:searchQuery]) {
        return true;
    }
    return false;
}

- (void)onUpdated:(NVSourceUpdateCallback) callback {
    updatedCallback = callback;
}

- (void)setQuery:(NSString *) query {
    searchQuery = query;
    [self update: specs];
    updatedCallback();
}

-(NSArray<NSString*>*)getDims{
    return [dims allKeys];
}

-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim{
    return dims[dim];
}

-(NSArray<NSDictionary*>*)getSpecsIn:(long) section{
    NSString *dim = [self getDims][section];
    return dims[dim];
}

-(NVColorSpec)getSpecAt:(NSIndexPath *) indexPath{
    NSDictionary *dict = [self getSpecsIn:indexPath.section][indexPath.item];
    return [NVColorSource value: dict];
}

+(NVColorSpec)value:(NSDictionary*) specDict {
    NVColorSpec spec = {
        .hex = specDict[@"hex"],
        .alpha = [specDict[@"aplha"] floatValue],
        .specCode = specDict[@"specCode"],
        .desc = specDict[@"desc"],
//        NSArray<NSString*>* dim;    // [@"背景色"]
        .fillMode = [specDict[@"fillMode"] boolValue],
        .borderMode = [specDict[@"borderMode"] boolValue]
    };
    return spec;
}

@end


