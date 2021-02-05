//
//  MSModelObjectCommon.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/2/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@protocol MSModelObjectCommon <NSObject>
@property(readonly, copy, nonatomic) NSString *objectID;
@end


@interface MSModelObjectCommon : NSObject <MSModelObjectCommon>
{
//    MSModelObjectCache *_cache;
    NSString *_objectID;
}

+ (unsigned long long)traits;
+ (BOOL)persistsObjectID;
+ (id)generateObjectID;
+ (id)defaultName;
+ (id)metadataForKey:(id)arg1 persistentIdentifier:(id)arg2 objectID:(id)arg3 inDictionary:(id)arg4;
+ (void)storeMetadata:(id)arg1 forKey:(id)arg2 persistentIdentifier:(id)arg3 objectID:(id)arg4 inDictionary:(id)arg5;
@property(copy, nonatomic) NSString *primitiveObjectID; // @synthesize primitiveObjectID=_objectID;
- (BOOL)propertiesAreEqual:(id)arg1 forPurpose:(unsigned long long)arg2;
- (void)enumerateDescendantsUsingBlock:(id)arg1 withAncestors:(id)arg2;
- (void)enumerateDescendantsIncludingAncestors:(BOOL)arg1 usingBlock:(id)arg2;
- (void)enumerateChildrenUsingBlock:(id)arg1;
- (unsigned long long)traits;
- (id)generateObjectID;
@property(readonly, copy, nonatomic) NSString *objectID;
- (void)enumerateProperties:(id)arg1;
- (void)setNilValueForKey:(id)arg1;
- (id)defaultName;
- (void)objectDidInit;
- (void)initializeUnsetObjectPropertiesWithDefaults;
- (void)performInitEmptyObject;
- (id)initWithMinimalSetup;
- (id)initWithDefaults:(BOOL)arg1 block:(id)arg2;
- (id)init;
@property(readonly, nonatomic) NSArray *overridePointAttributeNamesForOverridePropertyMigration;
@property(readonly, copy) NSString *description;
- (id)treeAsDictionary;
- (id)simpleTreeStructure;
- (id)treeStructure;
- (void)appendTreeStructureToString:(id)arg1 withIndent:(unsigned long long)arg2;
- (void)appendSimpleStructureToString:(id)arg1 withIndent:(unsigned long long)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

