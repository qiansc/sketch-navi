//
//  MSLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSStyle.h"
#import "MSRect.h"
#import "MSCurvePoint.h"
#import "_MSLayer.h"
#import "MSArtboardGroup.h"
#import "MSPath.h"

@interface MSLayer : _MSLayer
{
    long long skipDrawingSelectionCounter;
    BOOL _transformFromRootIsCached;
//    MSUnitCoordinateSpace *_unitCoordinateSpace;
    struct CGAffineTransform _transformForConvertingFromRoot;
}

+ (void)makeLayerNamesUnique:(id)arg1 withOptions:(long long)arg2;
+ (id)keyPathsForValuesAffectingLastNameComponent;
+ (id)defaultName;
+ (unsigned long long)traits;
+ (id)layerWithPath:(id)arg1;
+ (id)keyPathsForValuesAffectingUserVisibleRotation;
+ (double)rotationForUserVisibleRotation:(double)arg1;
+ (double)userVisibleRotationForRotation:(double)arg1;
+ (double)normalizeUserVisibleRotation:(double)arg1;
- (BOOL)ancestorsOrSelfHaveInferredLayout;
- (BOOL)hasEnabledFill;
- (void)rect:(id)arg1 didChangeFromRect:(struct CGRect)arg2;
- (id)allSymbolInstancesInChildren;
- (BOOL)canLockProportions;
- (BOOL)canScale;
- (BOOL)canRotate;
@property(readonly, nonatomic) BOOL isLayerExportable;
- (id)layerWithID:(id)arg1;
- (void)setIsFlippedVertical:(BOOL)arg1;
- (void)setIsFlippedHorizontal:(BOOL)arg1;
- (void)setRotation:(double)arg1;
- (void)endEditingFrame;
- (void)beginEditingFrame;
- (void)setHeightRespectingProportions:(double)arg1;
- (void)setWidthRespectingProportions:(double)arg1;
@property(nonatomic) struct CGPoint center;
@property(nonatomic) struct CGPoint origin;
@property(nonatomic) struct CGRect rect;
- (void)setValue:(id)arg1 forUndefinedKey:(id)arg2;
- (void)setNilValueForKey:(id)arg1;
- (void)setBooleanOperation:(long long)arg1;
- (BOOL)canBeTransformed;
- (void)multiplyBy:(double)arg1;
- (void)concatAncestorsAndSelfTransforms;
- (id)transform;
@property(readonly, nonatomic) struct CGAffineTransform CGTransformForFrame;
- (id)transformForRect:(struct CGRect)arg1;
@property(nonatomic) struct _CHTransformStruct transformStruct;
//@property(readonly, nonatomic) id <MSLayerCoordinateSpace> rulerCoordinateSpace;
//@property(readonly, nonatomic) id <MSLayerCoordinateSpace> unitCoordinateSpace;
- (void)invalidateTransformForConvertingFromRoot;
@property(readonly, nonatomic) struct CGAffineTransform transformForConvertingFromRoot; // @synthesize transformForConvertingFromRoot=_transformForConvertingFromRoot;
- (struct CGAffineTransform)transformForConvertingToLayer:(id)arg1;
- (struct CGAffineTransform)transformForConvertingFromLayer:(id)arg1;
- (struct CGVector)convertVector:(struct CGVector)arg1 fromLayer:(id)arg2;
- (struct CGVector)convertVector:(struct CGVector)arg1 toLayer:(id)arg2;
- (struct CGRect)convertRect:(struct CGRect)arg1 fromLayer:(id)arg2;
- (struct CGRect)convertRect:(struct CGRect)arg1 toLayer:(id)arg2;
- (struct CGPoint)convertPoint:(struct CGPoint)arg1 fromLayer:(id)arg2;
- (struct CGPoint)convertPoint:(struct CGPoint)arg1 toLayer:(id)arg2;
- (void)didMoveToParentObject;
- (BOOL)canContainLayer:(id)arg1;
- (id)childrenIncludingSelf:(BOOL)arg1;
- (id)children;
- (id)ancestorsAndSelfTransforms;
- (id)ancestorsAndSelf;
- (id)ancestors;
- (id)parentSymbol;
@property(readonly, nonatomic) MSArtboardGroup *parentArtboard;
//@property(readonly, nonatomic) _TtC11SketchModel24MSImmutableLayerAncestry *ancestry;
- (id)parentShape;
@property(readonly, nonatomic) __weak id *parentPage; // MSPage
@property(readonly, nonatomic) __weak id *parentGroup; // MSLayerGroup
- (BOOL)isOpen;
- (void)removeFromParent;
//- (void)moveInLayerTreeInBlock:(CDUnknownBlockType)arg1;
- (void)calculateProportions;
- (BOOL)isRectIntegral;
- (void)makeRectIntegral;
- (void)makeOriginIntegral;
@property(nonatomic) BOOL absoluteIsFlippedVertical;
@property(nonatomic) BOOL absoluteIsFlippedHorizontal;
@property(nonatomic) double absoluteRotation;
- (double)rotationDirection;
@property(nonatomic) struct CGPoint absoluteCenter;
@property(nonatomic) struct CGPoint absolutePosition;
- (id)absoluteRect;
- (void)setRulerOrigin:(struct CGPoint)arg1;
- (struct CGPoint)rulerOrigin;
@property(nonatomic) double rulerY;
@property(nonatomic) double rulerX;
@property(readonly, nonatomic) MSPath *pathForAbsoluteRect;
- (void)moveInAbsoluteCoordinatesBy:(struct CGPoint)arg1;
@property(nonatomic) struct CGRect absoluteBoundingBox;
- (id)pathInCoordinateSpace:(id)arg1;
@property(readonly, nonatomic) MSPath *pathInFrameWithTransforms;
@property(readonly, copy, nonatomic) MSPath *pathInFrame;
@property(readonly, nonatomic) MSPath *pathInBounds;
- (struct CGRect)frameForAlignmentRect:(struct CGRect)arg1;
- (struct CGRect)alignmentRectInCoordinateSpace:(id)arg1 options:(unsigned long long)arg2;
@property(readonly, nonatomic) BOOL hasTransforms;
@property(readonly, nonatomic) struct BCEdgePaddings influenceRectEdgePaddingsThatCascadeToContainedLayers;
- (struct CGRect)absoluteInfluenceRect;
- (void)invalidateModelCacheGenerationForObject:(id)arg1 property:(id)arg2;
- (struct CGSize)calculateMinimumSize;
- (void)layerDidResizeFromRect:(struct CGRect)arg1 corner:(long long)arg2;
- (void)layerDidEndResize;
- (void)layerWillStartResize;
- (void)resizeWithOldGroupSize:(struct CGSize)arg1;
- (unsigned long long)adjustedResizingConstraint;
@property(readonly, nonatomic) MSStyle *usedStyle;
- (id)selectableLayersWithOptions:(unsigned long long)arg1;
- (BOOL)limitsSelectionToBounds;
- (BOOL)isOpenForSelectionWithOptions:(unsigned long long)arg1;
- (BOOL)isSelectableOnCanvasWithOptions:(unsigned long long)arg1;
@property(readonly, nonatomic) BOOL isExpanded;
@property(readonly, nonatomic) BOOL isSelected;
- (void)select:(BOOL)arg1 byExtendingSelection:(BOOL)arg2 showSelection:(BOOL)arg3;
- (void)select:(BOOL)arg1 byExtendingSelection:(BOOL)arg2;
- (BOOL)containsSelectedItemIncludingSelf:(BOOL)arg1;
- (void)moveBySuggestedOffset:(struct CGVector)arg1;
@property(readonly, nonatomic) struct CGRect bounds;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (BOOL)compareFrameFrom:(id)arg1 withComparisonforPurpose:(unsigned long long)arg2;
- (void)setName:(id)arg1;
- (id)valueForUndefinedKey:(id)arg1;
@property(nonatomic) double proportions;
@property(nonatomic) BOOL constrainProportions;
- (struct CGRect)frameForTransforms;
- (BOOL)hasEnabledBackgroundBlur;
- (id)rootForNameUniquing;
- (id)namesOfAllLayersInContainer:(id)arg1;
- (void)makeNameUniqueInRoot:(id)arg1 withOptions:(long long)arg2;
- (void)makeNameUniqueWithOptions:(long long)arg1;
- (BOOL)isLine;
@property(copy, nonatomic) NSString *lastNameComponent;
- (id)name;
- (unsigned long long)traits;
- (id)initWithFrame:(struct CGRect)arg1;
- (void)objectDidInit;
- (void)performInitEmptyObject;
- (id)makeEnumeratorWithOptions:(unsigned long long)arg1;
- (void)applyUserVisibleRotation:(double)arg1 explicitRotationCenter:(id)arg2;
- (void)applyRotation:(double)arg1 explicitRotationCenter:(id)arg2;
@property(readonly, nonatomic) double userVisibleRotation;
- (long long)layoutDirection;
- (id)lastLayer;
- (id)firstLayer;
- (long long)indexOfLayer:(id)arg1;
- (id)layerAtIndex:(unsigned long long)arg1;
//- (BOOL)enumerateLayersWithOptions:(unsigned long long)arg1 block:(CDUnknownBlockType)arg2;
//- (BOOL)enumerateLayersWithOptions:(unsigned long long)arg1 classFilter:(Class)arg2 block:(CDUnknownBlockType)arg3;
//- (void)enumerateLayers:(CDUnknownBlockType)arg1;
- (BOOL)containsMultipleLayers;
- (BOOL)containsOneLayer;
- (BOOL)containsLayers;
- (BOOL)containsNoOrOneLayers;
- (unsigned long long)containedLayersCount;
- (id)containedLayers;
- (id)setupWithLayerBuilderDictionary:(id)arg1;
- (id)hitTestablePathInBoundsForZoomValue:(double)arg1;
- (BOOL)hitTestPoint:(struct CGPoint)arg1 inPath:(id)arg2 zoomValue:(double)arg3;
- (BOOL)containsPointAsPath:(struct CGPoint)arg1 options:(unsigned long long)arg2 zoomValue:(double)arg3;
- (BOOL)isLayerAtIndex:(unsigned long long)arg1 maskedAtPoint:(struct CGPoint)arg2 zoomValue:(double)arg3;
- (BOOL)isTooSmallForPreciseHitTestingAtZoomValue:(double)arg1;
- (BOOL)shouldHitTestOnFill:(id)arg1;
- (BOOL)hitTestAsPath;
- (BOOL)hitTestRect:(struct CGRect)arg1 options:(unsigned long long)arg2;
- (BOOL)containsPoint:(struct CGPoint)arg1 options:(unsigned long long)arg2 zoomValue:(double)arg3;
- (id)selectionHitTest:(struct CGPoint)arg1 options:(unsigned long long)arg2 zoomValue:(double)arg3;
- (void)resetConstraints;
//- (void)changeValueForKeysInBlock:(CDUnknownBlockType)arg1;
@property(nonatomic) BOOL hasFixedEdges;
- (void)setFixed:(BOOL)arg1 forEdge:(unsigned long long)arg2;
@property(nonatomic) BOOL hasFixedHeight;
@property(nonatomic) BOOL hasFixedWidth;
@property(nonatomic) BOOL hasFixedBottom;
@property(nonatomic) BOOL hasFixedTop;
@property(nonatomic) BOOL hasFixedRight;
@property(nonatomic) BOOL hasFixedLeft;
- (BOOL)hasFixedEdge:(unsigned long long)arg1;
@property(readonly, nonatomic) BOOL canFixHeight;
@property(readonly, nonatomic) BOOL canFixWidth;
@property(readonly, nonatomic) BOOL canFixBottom;
@property(readonly, nonatomic) BOOL canFixTop;
@property(readonly, nonatomic) BOOL canFixRight;
@property(readonly, nonatomic) BOOL canFixLeft;
- (id)resizingConstraintKeys;
@property(readonly, nonatomic) NSArray *CSSAttributes;
- (id)CSSTransformString;
@property(readonly, nonatomic) NSString *CSSAttributeString;
- (id)swatchesReferencedInDocument:(id)arg1;
- (id)sharedStylesReferencedInDocument:(id)arg1;
- (void)setIsVisible:(BOOL)arg1;
//- (void)followMaskChainForLayerAtIndex:(unsigned long long)arg1 usingBlock:(CDUnknownBlockType)arg2;
- (id)closestClippingLayer;
- (id)candidatesForMasking;
- (BOOL)isPartOfClippingMask;
- (BOOL)hasClippingMask;
- (id)enumeratorWithOptions:(unsigned long long)arg1;
@property(readonly, nonatomic) struct CGAffineTransform transformForConvertingFromParentCoordinateSpace;
@property(readonly, nonatomic) struct CGAffineTransform transformForConvertingToParentCoordinateSpace;
//@property(readonly, nonatomic) id <MSLayerCoordinateSpace> parentCoordinateSpace;
- (struct CGAffineTransform)transformForConvertingFromCoordinateSpace:(id)arg1;
- (struct CGAffineTransform)transformForConvertingToCoordinateSpace:(id)arg1;
- (struct CGVector)convertVector:(struct CGVector)arg1 fromCoordinateSpace:(id)arg2;
- (struct CGVector)convertVector:(struct CGVector)arg1 toCoordinateSpace:(id)arg2;
- (struct CGRect)convertRect:(struct CGRect)arg1 fromCoordinateSpace:(id)arg2;
- (struct CGRect)convertRect:(struct CGRect)arg1 toCoordinateSpace:(id)arg2;
- (struct CGPoint)convertPoint:(struct CGPoint)arg1 fromCoordinateSpace:(id)arg2;
- (struct CGPoint)convertPoint:(struct CGPoint)arg1 toCoordinateSpace:(id)arg2;
- (void)applyOverride:(id)arg1 document:(id)arg2;
- (void)applyOverrides:(id)arg1 document:(id)arg2 visitedSymbols:(id)arg3;
- (id)overridePointsWithParent:(id)arg1 overrides:(id)arg2 document:(id)arg3;
@property(retain, nonatomic) NSString *dataSupplierIdentifier;
- (void)replaceFonts:(id)arg1;
- (void)updateSharedStyleReferencesFrom:(id)arg1 to:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly, nonatomic) BOOL isFlippedHorizontal;
@property(readonly, nonatomic) BOOL isFlippedVertical;
@property(readonly, nonatomic) BOOL isVisible;
@property(readonly, nonatomic) NSString *objectID;
@property(readonly, nonatomic) double rotation;
@property(readonly) Class superclass;

@end
