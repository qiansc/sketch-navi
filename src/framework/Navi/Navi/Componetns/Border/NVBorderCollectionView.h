//
//  NVBorderCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVBorderSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

@interface NVBorderCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVBorderSource *dataSource;

@end
