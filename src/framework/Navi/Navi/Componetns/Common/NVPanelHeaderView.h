//
//  NVPanelHeaderView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVPanelHeaderView : NSView

@property (nonatomic, strong) NSTextField *titleTextField;
@property (nonatomic, strong) NSButton *button;

@property (nonatomic) NSTextField *titleLabel;
@property (nonatomic) NSButton *infoButton;
@property (nonatomic) NSButton *toggleButton;

@end

NS_ASSUME_NONNULL_END
