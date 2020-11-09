//
//  NVMarginPanel.h
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVMarginCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVMarginPanel : NVPanel

@property (nonatomic,strong) IBOutlet NVMarginCollectionView *collectionView;
@property (nonatomic,strong) NSArray<MSLayer*> *selections;

@end

NS_ASSUME_NONNULL_END
