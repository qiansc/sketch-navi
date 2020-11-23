//
//  NVWeightCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVWeightSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVWeightCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NVWeightSource *dataSource;
@end

NS_ASSUME_NONNULL_END
