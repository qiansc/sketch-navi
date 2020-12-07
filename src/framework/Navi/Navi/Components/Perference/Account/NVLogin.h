//
//  NVLogin.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVLogin : NSViewController

@property (readwrite, strong) IBOutlet NSView *accountLoginView;
@property (readwrite, strong) IBOutlet NSView *accountUserView;


@property (readwrite, strong) IBOutlet NSTextField *nameField;
@property (readwrite, strong) IBOutlet NSTextField *codeField;
@property (readwrite, strong) IBOutlet NSButton *codeButton;
@property (readwrite, strong) IBOutlet NSButton *loginButton;

@property (readwrite, strong) IBOutlet NSPopUpButton *domainButton;
@property (readwrite, strong) IBOutlet NSView *infoView;
@property (readwrite, strong) IBOutlet NSTextField *infoField;

@property (readwrite, strong) IBOutlet NSTextField *usernameField;
@property (readwrite, strong) IBOutlet NSButton *logoutButton;

- (void)processCodeVerifyResponse:(NSData*) data;

@end

NS_ASSUME_NONNULL_END
