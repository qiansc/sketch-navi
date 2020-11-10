//
//  NVLineCollectionView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVLineSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVLineCollectionView : NVCollectionViewWithHeader<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVLineSource *dataSource;

@end

NS_ASSUME_NONNULL_END
