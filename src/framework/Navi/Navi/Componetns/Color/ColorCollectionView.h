//
//  ColorCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ColorSectionHeader.h"
#import "ColorCollectionItem.h"
#import "NVColorSource.h"
#import "NVCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColorCollectionView : NVCollectionView<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NVColorSource *source;

@end

NS_ASSUME_NONNULL_END
