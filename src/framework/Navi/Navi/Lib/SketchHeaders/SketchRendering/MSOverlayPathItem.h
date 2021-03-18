//
//  MSOverlayPathItem.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/9.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSOverlayItem.h"

@interface MSOverlayPathItem : MSOverlayItem
{
    MSPath *_transformedPath;
    // Error parsing type: A^v, name: _transformedPathAtomicPointer
    struct CGColor *_colorRef;
    MSPath *_path;
    double _lineWidth;
    NSArray *_dashes;
    struct CGAffineTransform _transform;
}

+ (id)itemForPath:(id)arg1 transform:(struct CGAffineTransform)arg2 color:(struct CGColor *)arg3 lineWidth:(double)arg4 dashes:(id)arg5;
+ (id)itemForPath:(id)arg1 transform:(struct CGAffineTransform)arg2 color:(struct CGColor *)arg3 lineWidth:(double)arg4;
+ (id)filledItemForPath:(id)arg1 transform:(struct CGAffineTransform)arg2 color:(struct CGColor *)arg3;
@property(readonly, copy, nonatomic) NSArray *dashes; // @synthesize dashes=_dashes;
@property(readonly, nonatomic) double lineWidth; // @synthesize lineWidth=_lineWidth;
@property(readonly, nonatomic) struct CGAffineTransform transform; // @synthesize transform=_transform;
@property(readonly, nonatomic) MSPath *path; // @synthesize path=_path;
@property(readonly, nonatomic) struct CGColor *color; // @synthesize color=_colorRef;
@property(readonly, nonatomic) MSPath *transformedPath;
@property(readonly, nonatomic) BOOL hasDashes;
@property(readonly, nonatomic) BOOL isFilled;
- (void)dealloc;
- (id)initWithPath:(id)arg1 transform:(struct CGAffineTransform)arg2 color:(struct CGColor *)arg3 lineWidth:(double)arg4 dashes:(id)arg5;
- (id)init;

@end
