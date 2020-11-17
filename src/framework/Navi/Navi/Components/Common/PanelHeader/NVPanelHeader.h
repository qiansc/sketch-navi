//
//  NVPanelHeader.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelInfoButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPanelHeader : NSViewController

@property (weak) IBOutlet NSTextField *titleLabel;
@property (strong) IBOutlet NVPanelInfoButton *infoButton;
@property (strong) IBOutlet NSButton *toggleButton;
@property (strong) IBOutlet NSButton *toggleBackgroundButton;

+ (instancetype)viewControllerFromNIB;

@end

NS_ASSUME_NONNULL_END
