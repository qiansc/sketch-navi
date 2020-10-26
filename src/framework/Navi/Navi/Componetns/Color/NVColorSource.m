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
    NSInteger mod;
    NSString *shapeMod; // Text / ShapePath / other
    NSString *themeMod; // default /dark / night

}

-(instancetype)init{
    NVColorSource *s = [super init];
    mod = 0;
    shapeMod = @"other";
    themeMod = @"default";
    return s;
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
            }
         }
    }
    updatedCallback();
}

-(BOOL)filter:(NSDictionary*) specDict {

    if (mod == 1 && [specDict[@"borderMode"] boolValue] == NO) {
        return false;
    } else if(mod != 1 && [specDict[@"fillMode"] boolValue] == NO) {
        return false;
    }

    if ([shapeMod isEqual:@"Text"]) {
        if (![specDict[@"shapeMode"] isEqual:@"Text"]) return false;
    } else {
        if ([specDict[@"shapeMode"] isEqual:@"Text"]) return false;
    }

    if (searchQuery == nil || searchQuery.length == 0) {
        return true;
    }
    for(NSString *dim in specDict[@"dim"]) {
        if ([dim containsString:searchQuery]) return true;
    }
    NVColorSpec spec = [NVColorSource value:specDict];
    
    if ([spec.hex containsString:searchQuery]) {
        return true;
    } else if ([spec.specCode containsString:searchQuery]) {
        return true;
    } else if ([specDict[@"cname"] containsString:searchQuery]) {
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

- (void)setMode:(NSInteger) mode {
    mod = mode;
    [self update: specs];
    updatedCallback();
}

- (void)setShapeMode:(NSString *) mode {
    NSString *name = [mode isEqual:@"MSTextLayer"] ? @"Text" : @"Others";
    if (![shapeMod isEqual:name]) {
        shapeMod = name;
        [self update: specs];
        updatedCallback();
    }
}

- (void)setThemeMode:(NSString *) mode {
    if (![themeMod isEqual:mode]) {
        themeMod = mode;
        [self update: specs];
        updatedCallback();
    }
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
        .hex = specDict[@"mods"][0][@"color"],
        .alpha = [specDict[@"mods"][0][@"opacity"] floatValue],
        .specCode = specDict[@"cnum"],
        .desc = specDict[@"cmeaning"],
//        NSArray<NSString*>* dim;    // [@"背景色"]
//        .fillMode = [specDict[@"fillMode"] boolValue],
//        .borderMode = [specDict[@"borderMode"] boolValue]
    };
    return spec;
}

@end


