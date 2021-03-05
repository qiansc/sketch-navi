//
//  _MSSharedObject.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@interface _MSSharedObject : MSModelObject
{
    NSString *_name;
    MSModelObjectCommon *_value;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_value:(id)arg1;
- (void)setRaw_name:(id)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(retain, nonatomic) MSModelObjectCommon *value; // @synthesize value=_value;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
- (void)performInitWithImmutableModelObject:(id)arg1;
//- (void)enumerateChildrenUsingBlock:(CDUnknownBlockType)arg1;
//- (void)enumerateProperties:(CDUnknownBlockType)arg1;

@end

