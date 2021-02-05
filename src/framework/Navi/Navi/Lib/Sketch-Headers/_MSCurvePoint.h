//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jul  6 2018 12:02:43).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MSModelObject.h"

@interface _MSCurvePoint : MSModelObject
{
    double _cornerRadius;
    struct CGPoint _curveFrom;
    long long _curveMode;
    struct CGPoint _curveTo;
    BOOL _hasCurveFrom;
    BOOL _hasCurveTo;
    struct CGPoint _point;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_point:(struct CGPoint)arg1;
- (void)setRaw_hasCurveTo:(BOOL)arg1;
- (void)setRaw_hasCurveFrom:(BOOL)arg1;
- (void)setRaw_curveTo:(struct CGPoint)arg1;
- (void)setRaw_curveMode:(long long)arg1;
- (void)setRaw_curveFrom:(struct CGPoint)arg1;
- (void)setRaw_cornerRadius:(double)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(nonatomic) struct CGPoint point; // @synthesize point=_point;
@property(nonatomic) BOOL hasCurveTo; // @synthesize hasCurveTo=_hasCurveTo;
@property(nonatomic) BOOL hasCurveFrom; // @synthesize hasCurveFrom=_hasCurveFrom;
@property(nonatomic) struct CGPoint curveTo; // @synthesize curveTo=_curveTo;
@property(nonatomic) long long curveMode; // @synthesize curveMode=_curveMode;
@property(nonatomic) struct CGPoint curveFrom; // @synthesize curveFrom=_curveFrom;
@property(nonatomic) double cornerRadius; // @synthesize cornerRadius=_cornerRadius;
- (void)performInitWithImmutableModelObject:(id)arg1;
- (void)enumerateChildrenUsingBlock:(id)arg1;
- (void)enumerateProperties:(id)arg1;

@end
