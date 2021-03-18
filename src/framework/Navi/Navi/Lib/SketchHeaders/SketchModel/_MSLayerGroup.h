//
//  _MSLayerGroup.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSStyledLayer.h"
#import "MSGroupLayout.h"

@interface _MSLayerGroup : MSStyledLayer
{
    BOOL _hasClickThrough;
    NSString *_sharedObjectID;
    MSGroupLayout *_groupLayout;
    NSMutableArray *_layers;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
+ (BOOL)hasClickThroughDefault;
+ (id)defaultLayout;
+ (id)defaultFrame;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_layers:(id)arg1;
- (void)setRaw_groupLayout:(id)arg1;
- (void)setRaw_sharedObjectID:(id)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)moveLayerFromIndex:(unsigned long long)arg1 toIndex:(unsigned long long)arg2;
- (void)removeAllLayers;
- (void)removeLayersAtIndexes:(id)arg1;
- (void)removeLayerAtIndex:(unsigned long long)arg1;
- (void)removeLayer:(id)arg1;
- (void)insertLayers:(id)arg1 afterLayer:(id)arg2;
- (void)insertLayer:(id)arg1 afterLayer:(id)arg2;
- (void)insertLayers:(id)arg1 beforeLayer:(id)arg2;
- (void)insertLayer:(id)arg1 beforeLayer:(id)arg2;
- (void)insertLayer:(id)arg1 atIndex:(unsigned long long)arg2;
- (void)addLayers:(id)arg1;
- (void)addLayer:(id)arg1;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(retain, nonatomic) NSArray *layers; // @synthesize layers=_layers;
@property(retain, nonatomic) MSGroupLayout *groupLayout; // @synthesize groupLayout=_groupLayout;
@property(retain, nonatomic) NSString *sharedObjectID; // @synthesize sharedObjectID=_sharedObjectID;
@property(nonatomic) BOOL hasClickThrough; // @synthesize hasClickThrough=_hasClickThrough;
- (void)performInitWithImmutableModelObject:(id)arg1;
- (void)enumerateChildrenUsingBlock:(id)arg1;
- (void)enumerateProperties:(id)arg1;
- (BOOL)hasDefaultLayout;

@end
