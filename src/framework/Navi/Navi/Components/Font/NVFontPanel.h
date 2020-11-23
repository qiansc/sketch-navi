//
//  NVFontPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVFontCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVFontPanel : NVPanel

@property (nonatomic,strong) IBOutlet NVFontCollectionView *collectionView;
@property (nonatomic,strong) NSArray<MSLayer*> *selections;
@property (nonatomic,strong) IBOutlet NSSegmentedControl *modeButton;


@end

NS_ASSUME_NONNULL_END
