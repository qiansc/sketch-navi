//
//  NVTextPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVTextCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVTextPanel : NVPanel

@property (nonatomic,strong) IBOutlet NVTextCollectionView *collectionView;
@property (nonatomic,strong) NSArray<MSLayer*> *selections;
@property (nonatomic,strong) IBOutlet NSSegmentedControl *modeButton;


@end

NS_ASSUME_NONNULL_END
