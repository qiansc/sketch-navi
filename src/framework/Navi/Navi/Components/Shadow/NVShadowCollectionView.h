//
//  NVShadowCollectionView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVShadowSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVShadowCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVShadowSource *dataSource;

@end

NS_ASSUME_NONNULL_END
