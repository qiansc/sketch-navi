//
//  NVTextCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVTextSectionHeader.h"
#import "NVTextSource.h"
#import "NVCollectionView.h"
#import "NVCollectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVTextCollectionView : NVCollectionView<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NVTextSource *source;
@property (nonatomic,strong) NVCollectionDelegate *toggleDelegate;
@property (nonatomic) BOOL semanticMode;

@end

NS_ASSUME_NONNULL_END
