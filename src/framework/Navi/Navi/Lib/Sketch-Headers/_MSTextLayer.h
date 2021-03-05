//
//  _MSTextLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSStyledLayer.h"
#import "MSAttributedString.h"
#import "MSImageData.h"

@interface _MSTextLayer : MSStyledLayer
{
//    MSAttributedString *_attributedString;
    BOOL _automaticallyDrawOnUnderlyingPath;
    BOOL _dontSynchroniseWithSymbol;
    struct CGRect _glyphBounds;
    BOOL _isBeingEdited;
    long long _lineSpacingBehaviour;
    MSImageData *_preview;
    long long _textBehaviour;
}

+ (BOOL)allowsFaulting;
+ (Class)immutableClass;
//- (void).cxx_destruct;
- (void)refaultChildrenAgainst:(id)arg1;
- (void)setRaw_textBehaviour:(long long)arg1;
- (void)setRaw_preview:(id)arg1;
- (void)setRaw_lineSpacingBehaviour:(long long)arg1;
- (void)setRaw_isBeingEdited:(BOOL)arg1;
- (void)setRaw_glyphBounds:(struct CGRect)arg1;
- (void)setRaw_dontSynchroniseWithSymbol:(BOOL)arg1;
- (void)setRaw_automaticallyDrawOnUnderlyingPath:(BOOL)arg1;
- (void)setRaw_attributedString:(id)arg1;
- (id)childCollaborationObjectWithID:(id)arg1 removing:(BOOL)arg2;
- (void)pluginDiffCompareChildrenAgainst:(id)arg1 treeComparison:(id)arg2;
- (void)syncPropertiesFromObject:(id)arg1;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)copyPropertiesToObject:(id)arg1 options:(unsigned long long)arg2;
- (void)setAsParentOnChildren;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (BOOL)hasDefaultValues;
- (void)performInitEmptyObject;
@property(nonatomic) long long textBehaviour; // @synthesize textBehaviour=_textBehaviour;
@property(retain, nonatomic) MSImageData *preview; // @synthesize preview=_preview;
@property(nonatomic) long long lineSpacingBehaviour; // @synthesize lineSpacingBehaviour=_lineSpacingBehaviour;
@property(nonatomic) BOOL isBeingEdited; // @synthesize isBeingEdited=_isBeingEdited;
@property(nonatomic) struct CGRect glyphBounds; // @synthesize glyphBounds=_glyphBounds;
@property(nonatomic) BOOL dontSynchroniseWithSymbol; // @synthesize dontSynchroniseWithSymbol=_dontSynchroniseWithSymbol;
@property(nonatomic) BOOL automaticallyDrawOnUnderlyingPath; // @synthesize automaticallyDrawOnUnderlyingPath=_automaticallyDrawOnUnderlyingPath;
@property(retain, nonatomic) MSAttributedString *attributedString; // @synthesize attributedString=_attributedString;
- (void)performInitWithImmutableModelObject:(id)arg1;
//- (void)enumerateChildrenUsingBlock:(CDUnknownBlockType)arg1;
//- (void)enumerateProperties:(CDUnknownBlockType)arg1;

@end

