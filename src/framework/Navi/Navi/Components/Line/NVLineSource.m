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

-(instancetype)init{
    NVLineSource *s = [super init];
    updatedCallback = ^void {};
    return s;
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
    return [spec.text containsString:searchQuery] || [spec.cmeaning containsString: searchQuery] || [spec.code containsString:searchQuery];
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
    return  [dims[dim] sortedArrayUsingComparator: ^NSComparisonResult(NSDictionary* s1, NSDictionary* s2) {
        return s1[@"index"] > s2[@"index"];
    }];
}

- (NVLineSpec)getSpecAt:(NSIndexPath *) indexPath {
    NSDictionary *dict = [self getSpecsIn:indexPath.section][indexPath.item];
    return [NVLineSource value: dict];
}

+ (NVLineSpec)value:(NSDictionary*) specDict {
    NVLineSpec spec = {
        .weight = [(NSNumber *)[specDict valueForKey:@"weight"] doubleValue],
        .code = specDict[@"code"],
        .cmeaning = specDict[@"cmeaning"],
        .text = specDict[@"text"],
        .index = [(NSNumber *)[specDict valueForKey:@"rowNumber"] doubleValue]
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
