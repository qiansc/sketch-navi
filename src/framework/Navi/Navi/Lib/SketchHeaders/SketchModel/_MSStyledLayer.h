//
//  _MSStyledLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSLayer.h"

@interface _MSStyledLayer : MSLayer
{
    long long _clippingMaskMode;
    BOOL _hasClippingMask;
    NSString *_sharedStyleID;
    MSStyle *_style;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_style:(id)arg1;
- (void)setRaw_sharedStyleID:(id)arg1;
- (void)setRaw_hasClippingMask:(BOOL)arg1;
- (void)setRaw_clippingMaskMode:(long long)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(retain, nonatomic) MSStyle *style; // @synthesize style=_style;
@property(retain, nonatomic) NSString *sharedStyleID; // @synthesize sharedStyleID=_sharedStyleID;
@property(nonatomic) BOOL hasClippingMask; // @synthesize hasClippingMask=_hasClippingMask;
@property(nonatomic) long long clippingMaskMode; // @synthesize clippingMaskMode=_clippingMaskMode;
- (void)performInitWithImmutableModelObject:(id)arg1;
//- (void)enumerateChildrenUsingBlock:(CDUnknownBlockType)arg1;
//- (void)enumerateProperties:(CDUnknownBlockType)arg1;

@end
