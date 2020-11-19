//
//  NVMaskSource.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMaskSource.h"

@implementation MaskPoint

@end

@implementation MaskStop

@end

@implementation NVMaskSource {
    NVSourceUpdateCallback updatedCallback;
    NSString *searchQuery;
    NSMutableDictionary *dims;
    NSArray<NSDictionary *> *specs;
    NSString *themeMod;
}

- (instancetype)init {
    NVMaskSource *source = [super init];
    themeMod = @"default";
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
    for(NSString *dim in [dims allKeys]) {
        if ([((NSMutableArray*)dims[dim]) count] < 2) {
            [others addObjectsFromArray:dims[dim]];
            [dims removeObjectForKey:dim];
        }
    }
    if ([others count] > 0) {
        dims[@"其他"] = others;
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
    NVMaskSpec spec = [NVMaskSource value:specDict];
    if ([spec.code containsString:searchQuery]) {
        return true;
    } else if ([spec.elementCode containsString:searchQuery]) {
        return true;
    }
    return false;
}

+ (NVMaskSpec)value: (NSDictionary *) specDict {
    NVMaskSpec spec = {
        .code = specDict[@"code"],
        .cclass = specDict[@"cclass"],
        .cmeaning = specDict[@"cmeaning"],
        .direction = specDict[@"direction"],
        .from = [MaskPoint new],
        .to = [MaskPoint new],
        .stops = [NSMutableArray new],
    };
    NSArray<NSDictionary *> *stops = specDict[@"stops"];
    for (int i = 0; i < stops.count; i++) {
        MaskStop *stop = [MaskStop new];
        stop.position = [(NSNumber *)[stops[i] valueForKey:@"position"] doubleValue];
        stop.alpha = [(NSNumber *)[stops[i] valueForKey:@"alpha"] doubleValue];
        NSString *hex = (NSString *)[stops[i] valueForKey:@"color"];
        stop.color =[MSColor fromHexColorString:hex withAlpha: stop.alpha];
        [spec.stops addObject:stop];
    }
    NSDictionary *from = specDict[@"from"];
    spec.from.x = [(NSNumber *)[from valueForKey:@"x"] doubleValue];
    spec.from.y = [(NSNumber *)[from valueForKey:@"y"] doubleValue];
    NSDictionary *to = specDict[@"to"];
    spec.to.x = [(NSNumber *)[to valueForKey:@"x"] doubleValue];
    spec.to.y = [(NSNumber *)[to valueForKey:@"y"] doubleValue];
    return spec;
}

- (void) onUpdated:(NVSourceUpdateCallback) callback {
    updatedCallback = callback;
}

- (void)setQuery: (NSString *) query {
    searchQuery = query;
    [self update: specs];
}

- (void)setSemanticMode:(BOOL) semanticMode {
    _semanticMode = semanticMode;
    updatedCallback();
}

- (NSArray<NSString *> *)getDims {
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

- (NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim{
    return dims[dim];
}

- (NSArray<NSDictionary*>*)getSpecsIn:(long) section{
    NSString *dim = [self getDims][section];
    return dims[dim];
}

- (NVMaskSpec)getSpecAt:(NSIndexPath *) indexPath{
    NSDictionary *dict = [self getSpecsIn:indexPath.section][indexPath.item];
    return [NVMaskSource value: dict];
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
