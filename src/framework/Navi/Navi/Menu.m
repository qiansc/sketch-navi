//
//  MenuController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Menu.h"
#import "Config.h"

@implementation Menu

NSString* _documentId;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPreferredContentSize:CGSizeMake(40, 450)];
    [self.view setAutoresizingMask:NSViewNotSizable];
    [self initButton];
}
-  (void)viewWillLayout {
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
    if (self.delegate) {
        [self.delegate viewWillLayoutSize: @{
            @"width": @(self.view.frame.size.width),
            @"height": @(self.view.frame.size.height),
            @"limitWidth": @(self.limitWidth)
        }];
    }
}

- (void)viewDidAppear{
//    [self.view setFrameSize:NSMakeSize(40, 450)];
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
}
- (void)didReceiveMemoryWarning {
    // [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillTransitionToSize:(NSSize)newSize {
    
}

- (void)initButton {

    [self.headStack addView:[Util separtorBox] inGravity: NSStackViewGravityBottom];

    NSBundle *frameworkBundle = [NSBundle bundleForClass:[Menu class]];

    NSArray<NSDictionary*>* options = [Config MenuOptions];
    
    for(NSDictionary *option in options) {
        
        NSString *id = option[@"id"];
        NSString *icon = option[@"icon"];
        NSURL *iconUrl = [NSURL fileURLWithPath:[frameworkBundle pathForResource: icon ofType:@"png"]];
        NSURL *activeUrl = [NSURL fileURLWithPath:[frameworkBundle pathForResource:  [icon stringByAppendingFormat:@"%@", @"-active"] ofType:@"png"]];

        NSButton *button = [self createButton:option[@"name"] icon: iconUrl activeIcon: activeUrl];

        NSStackViewGravity gravity = option[@"gravity"] ? [option[@"gravity"] longValue] : NSStackViewGravityTop;

        [self.headStack addView:button inGravity: gravity];
        [self.headStack addView:[Util separtorBox] inGravity: gravity];

        button.identifier = id;

        [button setTarget:self];
        [button setAction:@selector(buttonClick:)];

        if([id  isEqual: @"main"]) {
            self.mainButton = button;
        }

    }
}

-(void)buttonClick:(NSButton*)button {
    NSDictionary* option = [Config MenuOption: button.identifier];
    if ([option[@"type"] isEqual:@"PANEL"]) {
        if (button.state && ![self mainButton].state) {
            // 点击普通按钮时 如果总控Main未激活 则模拟激活 打开主面板
            [[self mainButton] performClick:@"callAction:"];
        }
        NSDictionary* opt = @{@"id": option[@"id"],@"documentId": _documentId};
        if (button.state) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"OPEN_PANEL" object:opt];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDE_PANEL" object:opt];
        }
    }

    
    if (self.delegate) {
        [self.delegate onButtonClick: @{
            @"view": button,
            @"option": option
        }];
    }
}

- (NSButton*)createButton:(NSString*) name icon: (NSURL *) iconUrl activeIcon:(NSURL *) activeIconUrl {
    NSButton *button = [[NSButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
    [button setImage:[Util createImage:iconUrl withSize: NSMakeSize(40, 40)]];
    [button setAlternateImage:[Util createImage:activeIconUrl withSize: NSMakeSize(40, 40)]];
    [button setBordered:NO];
    [button sizeToFit];
    [button setToolTip: name];
    [button setButtonType: NSButtonTypeToggle]; //NSButtonTypeMomentaryChange
    return button;
}

- (void)setDocumentId:(NSString*) documentId {
    self.view.identifier = [documentId stringByAppendingString:@"-navi-menu-panel"];
    _documentId = documentId;
}

- (void)updateLimitWidth {
    self.limitWidth = self.view.frame.size.width * 1;
}

+ (instancetype)generateWithDocumentId:(NSString*) documentId {
    Menu* menu = [self viewControllerFromNIB];
    [menu setDocumentId:documentId];
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFirst:) name:@"First" object:nil];
    return menu;
}

+ (instancetype)viewControllerFromNIB {
    // 从NIB里创建view及controller
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return[[Menu alloc] initWithNibName:@"Menu" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    // [[NSBundle mainBundle] loadNibNamed:@"MenuBtn" owner:self topLevelObjects:nil];
}

@end
