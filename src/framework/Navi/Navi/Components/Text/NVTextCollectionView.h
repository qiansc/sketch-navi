//
//  NVTextCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVTextSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVTextCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NVTextSource *dataSource;
@end

NS_ASSUME_NONNULL_END
