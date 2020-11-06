//
//  NVShadowPanel.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVPanel.h"
#import "NVShadowCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVShadowPanel : NVPanel

@property (strong) IBOutlet NVShadowCollectionView *collectionView;
@property (nonatomic, strong) NSArray<MSLayer *> *selections;

@end

NS_ASSUME_NONNULL_END
