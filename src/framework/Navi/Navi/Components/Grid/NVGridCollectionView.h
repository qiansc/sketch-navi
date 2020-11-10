//
//  NVGridCollectionView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVGridSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

@interface NVGridCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVGridSource *dataSource;

@end
