#import "MSLayer.h"

@class NSArray, NSString;

@interface MSLayerArray : NSObject<NSFastEnumeration>
{
    NSArray *_layers;
}

+ (id)emptyArray;
+ (id)arrayWithLayers:(id)arg1;
+ (id)arrayWithLayer:(id)arg1;
@property(copy, nonatomic) NSArray *layers; // @synthesize layers=_layers;
@property(readonly) unsigned long long hash;
- (BOOL)isEqual:(id)arg1;
@property(readonly, copy) NSString *description;
- (long long)indexOfLayer:(id)arg1;
- (MSLayer*)layerAtIndex:(long)arg1;
- (MSLayer*)lastLayer;
- (MSLayer*)firstLayer;
- (BOOL)containsMultipleLayers;
- (BOOL)containsOneLayer;
- (BOOL)containsLayers;
- (BOOL)containsNoOrOneLayers;
- (long long)containedLayersCount;
- (id)containedLayers;
- (id)commonArtboard;
- (id)layerToInsertAfter;
- (id)effectiveArtboard;
- (id)effectivePage;
- (id)uniqueParents;
- (id)parentOfFirstLayer;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)initWithLayers:(id)arg1;
- (id)copyByGivingNewObjectIDs;
// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) Class superclass;

@end

