//
//  NVHoriPanel.h
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVHoriCollectionView.h"
#import "MSLayerArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVHoriPanel : NVPanel

@property (nonatomic,strong) IBOutlet NVHoriCollectionView *collectionView;
@property (nonatomic,strong) MSLayerArray *selections;

@end

NS_ASSUME_NONNULL_END
