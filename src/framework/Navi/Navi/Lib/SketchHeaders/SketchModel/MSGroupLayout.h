//
//  MSGroupLayout.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//
#import "_MSGroupLayout.h"
#import "MSLayerGroup.h"

@interface MSGroupLayout : _MSGroupLayout
{
    BOOL _changingLayout;
}

- (id)inferredLayoutParentOrNil;
- (BOOL)isInferredLayoutOrInherits;
@property(readonly, nonatomic) BOOL isInferredLayout;
- (unsigned long long)layoutAnchorByResolvingPossibleConflictWithParent:(unsigned long long)arg1;
- (unsigned long long)layoutAnchor;
- (unsigned long long)usedLayoutAnchor;
- (unsigned long long)axis;
- (BOOL)isChangingLayout;
- (void)postLayoutChangeCleanup;
- (unsigned long long)adjustConstraintForResizingSubLayer:(unsigned long long)arg1;
- (id)layersToConsiderForGroupBounds;
- (id)desiredGroupLayerOrder;
- (void)setOriginsOfContainedLayers:(id)arg1;
- (id)originsOfContainedLayers;
- (BOOL)shouldResizeToFitBounds:(struct CGRect)arg1;
- (BOOL)fixGeometryWithOptions:(long long)arg1;
- (void)didChangeLayout:(long long)arg1 info:(id)arg2;
- (id)willChangeLayout:(long long)arg1;
- (void)changeLayout:(long long)arg1 inBlock:(id)arg2;
- (void)groupDidResizeFromSize:(struct CGSize)arg1;
@property(readonly, nonatomic) id group;

@end

