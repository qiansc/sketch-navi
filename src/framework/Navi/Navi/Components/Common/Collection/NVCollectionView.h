//
//  NVCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN


@interface NVCollectionView : NSCollectionView<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NVCollectionDelegate *toggleDelegate;
@property (nonatomic) float displayHeight;

//- (void)setWrapperHeight:(float) height;

@end

NS_ASSUME_NONNULL_END