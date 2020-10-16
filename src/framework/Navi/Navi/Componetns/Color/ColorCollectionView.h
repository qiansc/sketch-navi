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

NS_ASSUME_NONNULL_BEGIN

@interface ColorCollectionView : NSCollectionView<NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout> {
    NSMutableDictionary* dict;
    NSMutableArray * arr;
}

@end

NS_ASSUME_NONNULL_END
