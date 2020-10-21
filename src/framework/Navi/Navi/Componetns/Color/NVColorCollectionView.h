//
//  NVColorCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVColorSectionHeader.h"
#import "NVColorSource.h"
#import "NVCollectionView.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVColorCollectionView : NVCollectionView<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NVColorSource *source;
@property (nonatomic,strong) NVCollectionDelegate *toggleDelegate;

@end

NS_ASSUME_NONNULL_END
