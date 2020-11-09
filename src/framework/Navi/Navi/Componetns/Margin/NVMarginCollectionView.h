//
//  NVMarginCollectionView.h
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVMarginSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

@interface NVMarginCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVMarginSource *dataSource;

@end
