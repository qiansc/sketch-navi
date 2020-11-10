//
//  NVGridPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVGridCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVGridPanel : NVPanel

@property (nonatomic,strong) IBOutlet NVGridCollectionView *collectionView;
@property (nonatomic,strong) NSArray<MSLayer*> *selections;

@end

NS_ASSUME_NONNULL_END
