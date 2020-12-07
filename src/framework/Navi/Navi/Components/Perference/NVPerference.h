//
//  NVPerference.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVLogin.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPerference : NSViewController

@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) IBOutlet NSView *accountItem;
@property (nonatomic, strong) IBOutlet NSView *accountLoginView;
@property (nonatomic, strong) IBOutlet NSView *accountUserView;

@property (nonatomic, strong) IBOutlet NSView *aboutItem;
@property (nonatomic, strong) IBOutlet NSView *aboutView;

@property (nonatomic, strong) IBOutlet NVLogin *loginController;

@end

NS_ASSUME_NONNULL_END
