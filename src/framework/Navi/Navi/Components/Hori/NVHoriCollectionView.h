//
//  NVHoriCollectionView.h
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVHoriSource.h"
#import "NVCollectionViewWithHeader.h"
#import "NVCollectionDelegate.h"

@interface NVHoriCollectionView : NVCollectionViewWithHeader<NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NVHoriSource *dataSource;

@end
