//
//  NVLineCollectionView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVLineSectionHeader.h"
#import "NVLineSource.h"
#import "NVCollectionView.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVLineCollectionView : NVCollectionView<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVLineSource *source;
@property (nonatomic, strong) NVCollectionDelegate *toggleDelegate;

@end

NS_ASSUME_NONNULL_END
