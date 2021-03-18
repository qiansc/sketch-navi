//
//  MSLayerGroup.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//
#import "_MSLayerGroup.h"

@interface MSLayerGroup : _MSLayerGroup // <MSLayerGroupProtocol, MSLayerContainer>
{
    long long _preCalculatedHasSelectedLayer;
    unsigned long long _disableAutomaticScalingCounter;
}

+ (id)groupWithLayers:(id)arg1;
+ (id)groupWithLayer:(id)arg1;
@property(nonatomic) unsigned long long disableAutomaticScalingCounter; // @synthesize disableAutomaticScalingCounter=_disableAutomaticScalingCounter;
@property(nonatomic) long long preCalculatedHasSelectedLayer; // @synthesize preCalculatedHasSelectedLayer=_preCalculatedHasSelectedLayer;
- (BOOL)ancestorsOrSelfHaveInferredLayout;
- (void)setInferredLayoutOnAxis:(unsigned long long)arg1 direction:(unsigned long long)arg2;
- (BOOL)shouldGrowSizeOfGroupForInferredLayout;
@property(nonatomic) BOOL hasInferredLayout;
- (id)candidatesForMasking;
- (void)layerDidEndResize;
- (void)layerWillStartResize;
- (void)rect:(id)arg1 didChangeFromRect:(struct CGRect)arg2;
- (void)resizeChildrenWithOldSize:(struct CGSize)arg1;
- (struct CGSize)calculateMinimumSize;
@property(readonly, nonatomic) BOOL isAutomaticScalingEnabled;
- (void)disableAutomaticScalingInBlock:(id)arg1;
- (void)multiplyBy:(double)arg1;
- (void)insertLayer:(id)arg1 afterLayerOrAtEnd:(id)arg2;
- (void)moveTransformsToChildren;
- (BOOL)fixGeometryWithOptions:(long long)arg1;
- (BOOL)groupBoundsShouldBeIntegral;
- (struct CGRect)optimalBoundingBox;
- (BOOL)isOpenForSelectionWithOptions:(unsigned long long)arg1;
- (BOOL)isSelectableOnCanvasWithOptions:(unsigned long long)arg1;
- (BOOL)containsSelectedItemIncludingSelf:(BOOL)arg1;
- (void)deselectLayerAndParent;
- (BOOL)isExpanded;
- (void)moveInLayerTreeInBlock:(id)arg1;
- (BOOL)shouldStripShadowsAndInnerShadow;
- (void)setStyle:(id)arg1;
- (BOOL)canContainLayer:(id)arg1;
- (id)defaultStyle;
- (id)parentGroupRecursive;
- (void)objectDidInit;
- (id)layerEnumeratorAvoidingFaultingWithOptions:(unsigned long long)arg1;
- (id)layerEnumeratorAvoidingFaultingWithOptions:(unsigned long long)arg1 passingTest:(id)arg2;
- (id)containedLayersAvoidingFaultingMatchingTraits:(unsigned long long)arg1;
- (id)containedLayersAvoidingFaultingMatchingTraits:(unsigned long long)arg1 test:(id)arg2;
- (void)enumerateLayersAvoidingFaultingWithOptions:(unsigned long long)arg1 recursively:(BOOL)arg2 passingTest:(id)arg3 usingBlock:(id)arg4;
- (void)enumerateLayersAvoidingFaultingWithOptions:(unsigned long long)arg1 passingTest:(id)arg2 usingBlock:(id)arg3;
- (void)correctInvalidGamma;
- (BOOL)enumerateLayersWithOptions:(unsigned long long)arg1 block:(id)arg2;
- (void)enumerateLayers:(id)arg1;
- (long long)indexOfLayer:(id)arg1;
- (id)layerAtIndex:(unsigned long long)arg1;
- (id)lastLayer;
- (id)firstLayer;
- (BOOL)containsMultipleLayers;
- (BOOL)containsOneLayer;
- (BOOL)containsLayers;
- (BOOL)containsNoOrOneLayers;
- (unsigned long long)containedLayersCount;
- (id)containedLayers;
- (id)CSSAttributeString;
- (void)applyOverride:(id)arg1 document:(id)arg2;
- (void)applyTransformsToLayers:(id)arg1;
- (id)ungroupReturningNextUngroupGroup;
- (BOOL)hasStyleOrTransform;
- (void)translateChildrenFrameToLayers:(id)arg1;
- (id)moveLayersToParent;
- (void)ungroupSingleChildDescendentGroups;
- (id)ungroup;
- (void)updateSwatchReferencesFrom:(id)arg1 to:(id)arg2;
- (void)updateSharedStyleReferencesFrom:(id)arg1 to:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly, nonatomic) NSArray *layers;
@property(readonly) Class superclass;

@end

