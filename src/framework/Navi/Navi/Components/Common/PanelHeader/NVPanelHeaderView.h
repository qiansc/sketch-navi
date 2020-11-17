//
//  NVPanelHeaderView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelInfoButton.h"
#import "NVPanelHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPanelHeaderView : NSView

@property (nonatomic, strong) NVPanelHeader *controller;

@end

NS_ASSUME_NONNULL_END
