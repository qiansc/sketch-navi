//
//  _MSShapePathLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSStyledLayer.h"

@interface _MSShapePathLayer : MSStyledLayer
{
    BOOL _edited;
    BOOL _isClosed;
    long long _pointRadiusBehaviour;
    NSMutableArray *_points;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
+ (BOOL)isEditedByDefault;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_points:(id)arg1;
- (void)setRaw_pointRadiusBehaviour:(long long)arg1;
- (void)setRaw_isClosed:(BOOL)arg1;
- (void)setRaw_edited:(BOOL)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)moveCurvePointFromIndex:(unsigned long long)arg1 toIndex:(unsigned long long)arg2;
- (void)removeAllCurvePoints;
- (void)removeCurvePointsAtIndexes:(id)arg1;
- (void)removeCurvePointAtIndex:(unsigned long long)arg1;
- (void)removeCurvePoint:(id)arg1;
- (void)insertCurvePoints:(id)arg1 afterCurvePoint:(id)arg2;
- (void)insertCurvePoint:(id)arg1 afterCurvePoint:(id)arg2;
- (void)insertCurvePoints:(id)arg1 beforeCurvePoint:(id)arg2;
- (void)insertCurvePoint:(id)arg1 beforeCurvePoint:(id)arg2;
- (void)insertCurvePoint:(id)arg1 atIndex:(unsigned long long)arg2;
- (void)addCurvePoints:(id)arg1;
- (void)addCurvePoint:(id)arg1;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(retain, nonatomic) NSArray *points; // @synthesize points=_points;
@property(nonatomic) long long pointRadiusBehaviour; // @synthesize pointRadiusBehaviour=_pointRadiusBehaviour;
@property(nonatomic) BOOL isClosed; // @synthesize isClosed=_isClosed;
@property(nonatomic) BOOL edited; // @synthesize edited=_edited;
- (void)performInitWithImmutableModelObject:(id)arg1;
//- (void)enumerateChildrenUsingBlock:(CDUnknownBlockType)arg1;
//- (void)enumerateProperties:(CDUnknownBlockType)arg1;
@property(nonatomic, readonly) BOOL hasDefaultCurvePoints;

@end

