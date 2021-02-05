//
//  NVPorderPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVPorderCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPorderPanel : NVPanel

@property (nonatomic,strong) IBOutlet NVPorderCollectionView *collectionView;
@property (nonatomic,strong) NSArray<MSLayer*> *selections;
@property (nonatomic,strong) NSArray<MSCurvePoint*>* points;

@end

NS_ASSUME_NONNULL_END
