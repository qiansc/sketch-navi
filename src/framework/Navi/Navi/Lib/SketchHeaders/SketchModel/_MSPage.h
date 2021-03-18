//
//  _MSPage.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//
#import "MSLayerGroup.h"

@interface _MSPage : MSLayerGroup
{
    BOOL _includeInCloudUpload;
//    MSSimpleGrid *_grid;
//    MSRulerData *_horizontalRulerData;
//    MSLayoutGrid *_layout;
//    MSRulerData *_verticalRulerData;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_verticalRulerData:(id)arg1;
- (void)setRaw_layout:(id)arg1;
- (void)setRaw_horizontalRulerData:(id)arg1;
- (void)setRaw_grid:(id)arg1;
- (void)setRaw_includeInCloudUpload:(BOOL)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
//@property(retain, nonatomic) MSRulerData *verticalRulerData; // @synthesize verticalRulerData=_verticalRulerData;
//@property(retain, nonatomic) MSLayoutGrid *layout; // @synthesize layout=_layout;
//@property(retain, nonatomic) MSRulerData *horizontalRulerData; // @synthesize horizontalRulerData=_horizontalRulerData;
//@property(retain, nonatomic) MSSimpleGrid *grid; // @synthesize grid=_grid;
@property(nonatomic) BOOL includeInCloudUpload; // @synthesize includeInCloudUpload=_includeInCloudUpload;
- (void)performInitWithImmutableModelObject:(id)arg1;
- (void)enumerateChildrenUsingBlock:(id)arg1;
- (void)enumerateProperties:(id)arg1;

@end
