//
//  NVPerference.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVLogin.h"
#import "NVCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPerference : NSViewController<NSTabViewDelegate>

@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) IBOutlet NSView *accountItem;
@property (nonatomic, strong) IBOutlet NSView *accountLoginView;
@property (nonatomic, strong) IBOutlet NSView *accountUserView;

@property (nonatomic, strong) IBOutlet NSView *aboutItem;
@property (nonatomic, strong) IBOutlet NSView *aboutView;

@property (nonatomic, strong) IBOutlet NSView *commonItem;
@property (nonatomic, strong) IBOutlet NSView *commonView;


@property (nonatomic, strong) IBOutlet NSTabView *tabView;

@property (nonatomic, strong) IBOutlet NVLogin *loginController;
@property (nonatomic, strong) IBOutlet NVCommon *commonController;

@end

NS_ASSUME_NONNULL_END
