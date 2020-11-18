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
@property (nonatomic) BOOL isLiveResize;

-(float)autoItemWithBetween:(float)minimumSize and:(float) maximumSize;

@end

NS_ASSUME_NONNULL_END
