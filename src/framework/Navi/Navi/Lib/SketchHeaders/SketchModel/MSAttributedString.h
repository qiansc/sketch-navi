//
//  MSAttributedString.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@interface MSAttributedString : NSObject <NSCopying>
{
    NSSet *_fontNames;
    // Error parsing type: A^v, name: _fontNamesAtomicPointer
    NSSet *_fontDescriptors;
    // Error parsing type: A^v, name: _fontDescriptorsAtomicPointer
    NSAttributedString *_attributedString;
    // Error parsing type: A^v, name: _attributedStringAtomicPointer
    NSAttributedString *_transformedAttributedString;
    // Error parsing type: A^v, name: _transformedAttributedStringAtomicPointer
    NSSet *_unavailableFontNames;
    // Error parsing type: A^v, name: _unavailableFontNamesAtomicPointer
    BOOL _textIsOverridden;
    NSAttributedString *_encodedAttributedString;
}

+ (id)replacementFontDescriptorWithFaceName:(id)arg1 size:(double)arg2;
+ (BOOL)isFontAvailable:(id)arg1;
+ (BOOL)isRequiredFontAvailableInDictionary:(id)arg1;
+ (id)fontNameInDictionary:(id)arg1;
+ (id)fontDescriptorInDictionary:(id)arg1;
+ (id)attributedStringWithRefreshedFontDescriptors:(id)arg1;
+ (id)decodeAttributedString:(id)arg1;
+ (id)encodeAttributedString:(id)arg1;
+ (id)refreshFontDescriptorsInDictionary:(id)arg1;
+ (id)decodeAttributesInDictionary:(id)arg1;
+ (id)encodeAttributesInDictionary:(id)arg1;
@property(readonly, copy, nonatomic) NSAttributedString *encodedAttributedString; // @synthesize encodedAttributedString=_encodedAttributedString;
@property(nonatomic) BOOL textIsOverridden; // @synthesize textIsOverridden=_textIsOverridden;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (id)debugDescription;
- (id)immutableModelObject;
- (id)encodedAttributesAtIndex:(unsigned long long)arg1;
- (id)attributedStringByReplacingFontNames:(id)arg1;
@property(readonly, nonatomic) BOOL areRequiredFontsAvailable;
@property(readonly, nonatomic) NSSet *unavailableFontNames;
- (id)calculateUnavailableFontNames;
@property(readonly, copy, nonatomic) NSSet *fontNames;
@property(readonly, copy, nonatomic) NSSet *fontDescriptors;
@property(readonly, nonatomic) NSAttributedString *transformedAttributedString;
- (id)calculateTransformedAttributedStringFromAtrributedString:(id)arg1;
@property(readonly, nonatomic) NSAttributedString *attributedString;
- (id)calculateAttributedString;
@property(readonly, nonatomic) NSString *string;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (void)encodeAsJSON:(id)arg1;
- (void)encodeWithArchiver:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithUnarchiver:(id)arg1;
- (id)initWithAttributedString:(id)arg1 colorSpace:(id)arg2 convert:(BOOL)arg3;
- (id)initWithEncodedAttributedString:(id)arg1;
- (id)init;
- (id)treeAsDictionary;

// Remaining properties
@property(readonly, nonatomic) NSString *archiveReferenceIdentifier_bc;

@end

