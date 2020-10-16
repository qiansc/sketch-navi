//
//  PanelHeader.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface PanelHeader : NSViewController

@property (weak) IBOutlet NSTextField *titleLabel;
@property (strong) IBOutlet NSButton *infoButton;
@property (strong) IBOutlet NSButton *toggleButton;

+ (instancetype)viewControllerFromNIB;

@end

NS_ASSUME_NONNULL_END
