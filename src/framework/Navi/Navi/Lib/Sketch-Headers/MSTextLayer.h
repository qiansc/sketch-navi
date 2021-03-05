//
//  MSTextLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "_MSTextLayer.h"

@interface MSTextLayer : _MSTextLayer
{
    // Error parsing type: Ai, name: ignoreDelegateNotificationsCounter
    BOOL _isEditingText;
//    id <MSTextLayerEditingDelegate> _editingDelegate;
    struct CGRect _previousRectCache;
}

+ (id)defaultValue;
//+ (void)maintainTextLayerBaselinesForLayers:(id)arg1 inBlock:(CDUnknownBlockType)arg2;
+ (id)keyPathsForValuesAffectingHasFixedHeight;
+ (id)keyPathsForValuesAffectingCanFixHeight;
//@property(nonatomic) __weak id <MSTextLayerEditingDelegate> editingDelegate; // @synthesize editingDelegate=_editingDelegate;
@property(nonatomic) struct CGRect previousRectCache; // @synthesize previousRectCache=_previousRectCache;
- (id)updateableColors;
- (void)updateColorsUsing:(id)arg1;
//- (void)updateColorsUsingBlock:(CDUnknownBlockType)arg1;
- (BOOL)canLockProportions;
- (BOOL)canScale;
- (BOOL)canBeTransformed;
- (BOOL)constrainProportions;
- (void)checkTextBehaviourAndClippingAfterResizeFromCorner:(long long)arg1 mayClip:(BOOL)arg2;
- (void)resizeWithOldGroupSize:(struct CGSize)arg1;
- (void)layerDidResizeFromRect:(struct CGRect)arg1 corner:(long long)arg2;
- (void)replaceTextPreservingAttributeRanges:(id)arg1;
- (void)setTextTransform:(unsigned long long)arg1 range:(struct _NSRange)arg2;
- (void)makeLowercase:(id)arg1;
- (void)makeUppercase:(id)arg1;
- (void)multiplyBy:(double)arg1;
- (id)attributeForKey:(id)arg1;
- (void)addAttribute:(id)arg1 value:(id)arg2;
- (void)addAttributes:(id)arg1 forRange:(struct _NSRange)arg2;
- (void)setAttributes:(id)arg1 forRange:(struct _NSRange)arg2;
- (void)addAttribute:(id)arg1 value:(id)arg2 forRange:(struct _NSRange)arg3;
//- (void)ignoreDelegateNotificationsInBlock:(CDUnknownBlockType)arg1;
@property(copy, nonatomic) NSString *stringValue;
//- (void)updateAttributedStringInBlock:(CDUnknownBlockType)arg1;
//- (void)setAttributedString:(id)arg1 unavailableFontsRectCalculationBlock:(CDUnknownBlockType)arg2;
- (void)setAttributedString:(id)arg1;
@property(copy, nonatomic) NSAttributedString *attributedStringValue;
- (void)layerStyleDidChange;
- (BOOL)isEmpty;
@property(copy, nonatomic) NSDictionary *styleAttributes;
@property(copy, nonatomic) MSColor *textColor;
@property(nonatomic) double lineHeight;
- (double)baseLineHeight;
@property(retain, nonatomic) NSNumber *characterSpacing;
@property(retain, nonatomic) NSString *fontPostscriptName;
@property(copy, nonatomic) NSFont *font;
@property(nonatomic) double fontSize;
@property(nonatomic) long long verticalAlignment;
@property(nonatomic) long long textAlignment;
- (void)setLeading:(double)arg1;
- (double)leading;
- (id)paragraphStyle;
- (void)setKerning:(float)arg1;
- (float)kerning;
- (id)pathsWithColorsFromGlyphsInBoundsWithParentGroupSplitByColorAttribute;
- (struct CGPoint)drawingPointForText;
- (double)startingPositionOnPath:(id)arg1;
- (double)defaultLineHeight:(id)arg1;
- (void)changeFont:(id)arg1;
- (id)shapeToUseForTextOnPath;
@property(nonatomic) BOOL isEditingText; // @synthesize isEditingText=_isEditingText;
- (void)updateNameFromStorage;
- (void)changeListType:(id)arg1;
//- (void)updateStyleInBlock:(CDUnknownBlockType)arg1;
- (BOOL)shouldMaintainBaseLineOnStyleChange;
- (struct CGRect)alignmentRectInCoordinateSpace:(id)arg1 options:(unsigned long long)arg2;
- (void)setRectAccountingForClipped:(struct CGRect)arg1;
- (void)fixParentGeometryIfNotAlreadyChangingLayout;
//- (void)adjustFrameToFitWithUnavilableFontsRectCalculationBlock:(CDUnknownBlockType)arg1;
- (void)adjustFrameToFit;
- (long long)assumedAlignment;
- (void)finishEditing;
- (double)baselineAdjustmentForLayoutManager:(id)arg1;
- (void)replaceMissingFontsIfNecessary;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (BOOL)compareAttributes:(id)arg1 withAttributes:(id)arg2;
- (void)syncTextStyleAttributes;
- (id)sharedObject;
- (void)setupBehaviour:(BOOL)arg1;
- (void)setTextBehaviour:(long long)arg1;
- (void)setTextBehaviour:(long long)arg1 mayAdjustFrame:(BOOL)arg2;
- (void)setStyle:(id)arg1;
- (void)object:(id)arg1 didChangeProperty:(id)arg2;
- (void)performInitEmptyObject;
- (void)objectDidInit;
- (id)initWithFrame:(struct CGRect)arg1 attributes:(id)arg2 documentColorSpace:(id)arg3 type:(long long)arg4;
- (id)initWithAttributedString:(id)arg1 documentColorSpace:(id)arg2 maxWidth:(double)arg3 convertColorSpace:(BOOL)arg4;
- (id)initWithFrame:(struct CGRect)arg1;
- (long long)layoutDirection;
- (id)setupWithLayerBuilderDictionary:(id)arg1;
- (void)embedInTransformedGroup;
- (long long)cornerForBaselineMaintaining;
- (unsigned long long)resizingConstraint;
- (BOOL)canFixHeight;
- (id)CSSAttributes;
- (void)writeStyleToPasteboard:(id)arg1;
- (void)invalidateFonts;
- (void)replaceFonts:(id)arg1;
- (void)resetSharedStyle;
- (void)setSharedStyle:(id)arg1;
- (id)foreignSharedStyles;
- (id)styleContainer;
- (void)reapplyPreviousAttributesFromString:(id)arg1 document:(id)arg2;
- (struct CGRect)findUnavailableFontRectStoredInDocument:(id)arg1 override:(id)arg2;
- (void)applyOverride:(id)arg1 document:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

