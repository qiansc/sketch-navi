//
//  MSLayerProtocol.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@protocol MSLayerTraits <NSObject>
+ (unsigned long long)traits;
- (unsigned long long)traits;
@end



@protocol MSLayerProtocol <NSObject, MSLayerTraits>
@property(readonly, nonatomic) BOOL isLayerExportable;
@property(readonly, nonatomic) struct CGPoint origin;
@property(readonly, nonatomic) struct BCEdgePaddings influenceRectEdgePaddingsThatCascadeToContainedLayers;
@property(readonly, nonatomic) struct CGAffineTransform CGTransformForFrame;
@property(readonly, nonatomic) BOOL hasTransforms;
@property(readonly, nonatomic) struct CGRect bounds;
@property(readonly, nonatomic) struct CGRect rect;
@property(readonly, nonatomic) NSString *objectID;
@property(readonly, nonatomic) double rotation;
@property(readonly, nonatomic) BOOL isFlippedVertical;
@property(readonly, nonatomic) BOOL isFlippedHorizontal;
@property(readonly, nonatomic) BOOL isVisible;
- (BOOL)hasEnabledFill;
- (NSArray *)childrenIncludingSelf:(BOOL)arg1;
- (NSArray *)children;
- (id)layerWithID:(NSString *)arg1;
- (NSAffineTransform *)transformForRect:(struct CGRect)arg1;
@end
