//
//  NVColorPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanelController.h"
#import "NVColorCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVColorPanel : NVPanelController

@property (nonatomic,strong) IBOutlet NVColorCollectionView *collectionView;
@property (nonatomic,strong) NSArray<MSLayer*> *selections;
@property (nonatomic,strong) IBOutlet NSSegmentedControl *modeButton;

@end

NS_ASSUME_NONNULL_END
