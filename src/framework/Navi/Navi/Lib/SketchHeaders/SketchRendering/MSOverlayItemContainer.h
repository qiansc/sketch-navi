//
//  MSOverlayItemContainer.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/9.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//
#import "MSOverlayPathItem.h"

@interface MSOverlayItemContainer : NSObject
{
    BOOL _isEmpty;
    NSArray *_pathItems;
    NSArray *_bitmapItems;
    NSArray *_labelItems;
    NSSet *_flowItems;
}

+ (id)containerWithPathItem:(id)arg1;
+ (id)containerWithPathItems:(id)arg1;
+ (id)container;
@property(readonly, nonatomic) BOOL isEmpty; // @synthesize isEmpty=_isEmpty;
@property(readonly, copy, nonatomic) NSSet *flowItems; // @synthesize flowItems=_flowItems;
@property(readonly, copy, nonatomic) NSArray *labelItems; // @synthesize labelItems=_labelItems;
@property(readonly, copy, nonatomic) NSArray *bitmapItems; // @synthesize bitmapItems=_bitmapItems;
@property(readonly, copy, nonatomic) NSArray<MSOverlayPathItem *> *pathItems; // @synthesize pathItems=_pathItems;
- (BOOL)isEqualToOverlayItemContainer:(id)arg1;
- (id)appendingItems:(id)arg1;
- (id)initWithPathItems:(id)arg1 bitmapItems:(id)arg2 labelItems:(id)arg3 flowItems:(id)arg4;
- (id)initWithPathItems:(id)arg1 bitmapItems:(id)arg2 labelItems:(id)arg3;
- (id)init;

@end
