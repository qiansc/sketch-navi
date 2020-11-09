//
//  MSColor.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import <Foundation/Foundation.h>
@class NSString;

@interface MSColor : NSObject
{
    double _alpha;
    double _blue;
    double _green;
    double _red;
    NSString *_swatchID;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_swatchID:(id)arg1;
- (void)setRaw_red:(double)arg1;
- (void)setRaw_green:(double)arg1;
- (void)setRaw_blue:(double)arg1;
- (void)setRaw_alpha:(double)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(retain, nonatomic) NSString *swatchID; // @synthesize swatchID=_swatchID;
@property(nonatomic) double red; // @synthesize red=_red;
@property(nonatomic) double green; // @synthesize green=_green;
@property(nonatomic) double blue; // @synthesize blue=_blue;
@property(nonatomic) double alpha; // @synthesize alpha=_alpha;

+ (id)colorWithRed:(double)arg1 green:(double)arg2 blue:(double)arg3 alpha:(double)arg4;

@end
