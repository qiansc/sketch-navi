//
//  ColorSpec.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorSource.h"
#import "NVSource.h"
#import "NVToggleBox.h"

@implementation NVColorSource {
    // NVSourceUpdateCallback updatedCallback;
    NSString *searchQuery;
    NSMutableDictionary *dims;
    NSArray<NSDictionary*> *specs;
    NSInteger mod;
    NSString *themeMod; // default /dark / night

}

-(instancetype)init{
    NVColorSource *s = [super init];
    mod = 0;
    themeMod = @"default";
    _semanticMode = NO;
    return s;
}

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
    NSMutableArray *others = [NSMutableArray new];
    for(NSString *dim in [dims allKeys]) {
        if ([((NSMutableArray*)dims[dim]) count] < 4) {
            [others addObjectsFromArray:dims[dim]];
            [dims removeObjectForKey:dim];
        }
    }
    if ([others count] > 0) {
        dims[@"其他"] = others;
    }
    if(self.updateDelegate) [self.updateDelegate onSourceUpdated];
}

-(BOOL)filter:(NSDictionary*) specDict {

    if (mod == 1 && [specDict[@"borderMode"] boolValue] == NO) {
        return false;
    } else if(mod != 1 && [specDict[@"fillMode"] boolValue] == NO) {
        return false;
    }

    if (self.isTextType) {
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
    if ([spec.cname containsString:searchQuery]) {
        return true;
    } else if ([spec.hex containsString:searchQuery]) {
        return true;
    } else if ([spec.specCode containsString:searchQuery]) {
        return true;
    } else if ([specDict[@"cname"] containsString:searchQuery]) {
        return true;
    }

    return false;
}

#pragma mark set & updatedCallback

- (void)setQuery:(NSString *) query {
    searchQuery = query;
    [self update: specs];
    if(self.updateDelegate) [self.updateDelegate onSourceUpdated];
}

- (void)setSemanticMode:(BOOL) mode {
    _semanticMode = mode;
    if(self.updateDelegate) [self.updateDelegate onSourceUpdated];
}

- (void)setMode:(NSInteger) mode {
    mod = mode;
    [self update: specs];
    if(self.updateDelegate) [self.updateDelegate onSourceUpdated];
}
- (BOOL)isFillMode {return mod == 0;}
- (BOOL)isBorderMode {return mod == 1;}

-(void)setShapeType:(NSString *)type {
    if (![self.shapeType isEqual:type]) {
        _shapeType = type;
        [self update: specs];
        if(self.updateDelegate) [self.updateDelegate onSourceUpdated];
    }
}
-(BOOL)isTextType{
    return [self.shapeType isEqual:@"MSTextLayer"];
}


- (void)setThemeMode:(NSString *) mode {
    if (![themeMod isEqual:mode]) {
        themeMod = mode;
        [self update: specs];
        if(self.updateDelegate) [self.updateDelegate onSourceUpdated];
    }
}


#pragma mark Dims & Data for Collection

-(NSArray<NSString*>*)getDims{
    NSArray<NSString*>* arr = [dims allKeys];
    NSMutableArray<NSString*>* rs = [NSMutableArray new];
    for(NSString * item in arr) {
        if (![item isEqual:@"其他"]) [rs addObject:item];
    }
    if ([arr count] != [rs count]) {
        [rs addObject:@"其他"];
    }


    return rs;
}

-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim{
    return dims[dim];
}

-(NSArray<NSDictionary*>*)getSpecsIn:(long) section{
    NSString *dim = [self getDims][section];
    return  [dims[dim] sortedArrayUsingComparator: ^NSComparisonResult(NSDictionary* s1, NSDictionary* s2) {
        return s1[@"cnum"] > s2[@"cnum"];
    }];
}

-(NVColorSpec)getSpecAt:(NSIndexPath *) indexPath{
    NSDictionary *dict = [self getSpecsIn:indexPath.section][indexPath.item];
    return [NVColorSource value: dict];
}

+(NVColorSpec)value:(NSDictionary*) specDict {
    NVColorSpec spec = {
        .hex = specDict[@"mods"][0][@"color"],
        .hex1 = specDict[@"mods"][1][@"color"],
        .hex2 = specDict[@"mods"][2][@"color"],
        .alpha = [specDict[@"mods"][0][@"opacity"] floatValue],
        .specCode = specDict[@"cnum"],
        .desc = specDict[@"cmeaning"],
        .cname = specDict[@"cname"]
    };
    return spec;
}


#pragma mark NSCollectionViewDataSource

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self getSpecsIn:section] count];
}
- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSString *itemId = [NSString stringWithFormat:@"Item-%hhd", self.semanticMode];
    return [collectionView makeItemWithIdentifier:itemId forIndexPath:indexPath];

}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return [[self getDims] count];
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == NSCollectionElementKindSectionHeader) {
        return [collectionView makeSupplementaryViewOfKind:kind withIdentifier: @"Header" forIndexPath:indexPath];
    }
    return nil;
}

@end


