//
//  NVCommon.h
//  Navi
//
//  Created by QIANSC on 2020/12/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVCommon : NSViewController


@property (readwrite, strong) IBOutlet NSView *infoView;
@property (readwrite, strong) IBOutlet NSTextField *infoField;

@property (readwrite, strong) IBOutlet NSPopUpButton *groupButton;
@property (readwrite, strong) IBOutlet NSPopUpButton *versionButton;
@property (readwrite, strong) IBOutlet NSPopUpButton *unitButton;

@property (readwrite, strong) IBOutlet NSTextField *updateField;
@property (readwrite, strong) IBOutlet NSButton *updateButton;

- (void)updateView;

@end

NS_ASSUME_NONNULL_END
