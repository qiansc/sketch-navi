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
#import "FlippedClipView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVColorPanel : NVPanelController

@property (strong) IBOutlet FlippedClipView *clipView;
@property (nonatomic,strong) ColorCollectionView *collectionView;
@property (strong) IBOutlet NSView *bView;

@end

NS_ASSUME_NONNULL_END
