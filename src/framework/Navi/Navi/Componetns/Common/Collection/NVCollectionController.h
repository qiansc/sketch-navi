//
//  NVCollectionController.h
//  Navi
//
//  Created by QIANSC on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVCollectionView.h"
#import "NVClipView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AfterResizeHandler)(float width, float height);

@interface NVCollectionController : NSViewController

@property (nonatomic, strong) AfterResizeHandler afterResize;
@property (strong) NVCollectionView* view;
@property (strong) NVClipView* clipView;

-(void)setCollectionView:(NSCollectionView *) view;

@end

NS_ASSUME_NONNULL_END
