//
//  NVColorPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PanelHeaderView.h"
#import "NVPanelController.h"
#import "ColorCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVColorPanel : NVPanelController

@property (nonatomic,strong) IBOutlet ColorCollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
