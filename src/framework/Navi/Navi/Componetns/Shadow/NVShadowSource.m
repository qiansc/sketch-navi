//
//  NVShadowSource.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVShadowSource.h"

@implementation NVShadowSource {
    NVSourceUpdateCallback updatedCallback;
    NSString *searchQuery;
    NSMutableDictionary *dims;
    NSArray<NSDictionary *> *specs;
}

- (instancetype)init {
    NVShadowSource *source = [super init];
    updatedCallback = ^void {};
    return source;
}

- (void)update:(NSArray<NSDictionary *> *) newSpecs {
    specs = newSpecs;
    dims = [NSMutableDictionary new];
    for (NSMutableDictionary* spec in specs) {
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
    for (NSString *dim in [dims allKeys]) {
        if ([((NSMutableArray *) dims[dim]) count] < 2) {
            [others addObjectsFromArray:dims[dim]];
            [dims removeObjectForKey:dim];
        }
    }
    updatedCallback();
}

- (BOOL)filter:(NSDictionary *) specDict {
    if (searchQuery == nil || searchQuery.length == 0) {
        return true;
    }
    for (NSString *dim in specDict[@"dim"]) {
        if ([dim containsString:searchQuery]) {
            return true;
        }
    }
    NVShadowSpec spec = [NVShadowSource value:specDict];
    if ([spec.code containsString:searchQuery]) {
        return true;
    }
    if ([spec.elementCode containsString:searchQuery]) {
        return true;
    }
    return false;
}

+ (NVShadowSpec)value: (NSDictionary *) specDict {
    NVShadowSpec spec = {
        .code = specDict[@"code"],
        .cclass = specDict[@"cclass"],
        .cline = specDict[@"cline"],
        .cmeaning = specDict[@"cmeaning"],
        .elementCode = specDict[@"elementCode"],
        .color = specDict[@"color"],
        .x = [specDict[@"x"] doubleValue],
        .y = [specDict[@"y"] doubleValue],
        .size = [specDict[@"size"] doubleValue],
        .opacity = [specDict[@"opacity"] doubleValue]
    };
    return spec;
}

- (void) onUpdated:(NVSourceUpdateCallback)callback {
    updatedCallback = callback;
}

- (void)setQuery:(NSString *)query {
    searchQuery = query;
    [self update: specs];
}

- (void)setSemanticMode:(BOOL)semanticMode {
    _semanticMode = semanticMode;
    updatedCallback();
}

- (NSArray<NSString *> *)getDims {
    NSArray<NSString *> *arr = [dims allKeys];
    NSMutableArray<NSString *> *rs = [NSMutableArray new];
    for (NSString *item in arr) {
        if (![item isEqual:@"其他"]) {
            [rs addObject:item];
        }
    }
    if ([arr count] != [rs count]) {
        [rs addObject: @"其他"];
    }
    return rs;
}

- (NSArray<NSDictionary *> *)getSpecsWith:(NSString *)dim {
    return dims[dim];
}

- (NSArray<NSDictionary *> *)getSpecsIn:(long)section {
    NSString *dim = [self getDims][section];
    return dims[dim];
}

- (NVShadowSpec)getSpecAt:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self getSpecsIn:indexPath.section][indexPath.item];
    return [NVShadowSource value: dict];
}

#pragma mark NSCollectionViewDataSource

- (NSInteger)collectionView:(NSCollectionView *) collectionView numberOfItemsInSection:(NSInteger) section {
    return [[self getSpecsIn:section] count];
}
- (NSCollectionViewItem *)collectionView:(NSCollectionView *) collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *) indexPath {
    NSString *itemId = [NSString stringWithFormat:@"Item-%hhd", self.semanticMode];
    return [collectionView makeItemWithIdentifier:itemId forIndexPath:indexPath];

}

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return [[self getDims] count];
}

- (NSView *)collectionView:(NSCollectionView *) collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind) kind atIndexPath:(NSIndexPath *) indexPath {
    if (kind == NSCollectionElementKindSectionHeader) {
        return [collectionView makeSupplementaryViewOfKind:kind withIdentifier: @"Header" forIndexPath:indexPath];
    }
    return nil;
}

@end
