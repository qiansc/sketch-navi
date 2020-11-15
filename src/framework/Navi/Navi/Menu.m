//
//  MenuController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Menu.h"
#import "Config.h"
#import "NVBundle.h"
#import "NVColor.h"
#import "NVImage.h"
// 临时代码
#import "NVArtboard.h"
#import "NVMenuButton.h"
#import "MSDocument.h"

@implementation Menu {
    NSWindow *artborad;
    NSButton *artboradButton;
    NSMutableDictionary* panelButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    [self.view setAutoresizingMask:NSViewNotSizable];
    [self initButton];
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangePanelState:) name:@"DID_TOOGLE_PANEL" object:nil];
}

- (void)initButton {

    panelButtons = [[NSMutableDictionary alloc]init];

    [self.headStack addView:[Util separtorBox] inGravity: NSStackViewGravityBottom];

    NSArray<NSDictionary*>* options = [Config MenuOptions];

    for(NSDictionary *option in options) {

        NSString *id = option[@"id"];
        NSButton *button = [self createButton:option[@"name"] icon: option[@"icon"]];

        NSStackViewGravity gravity = option[@"gravity"] ? [option[@"gravity"] longValue] : NSStackViewGravityTop;

        [self.headStack addView:button inGravity: gravity];
        [self.headStack addView:[Util separtorBox] inGravity: gravity];

        button.identifier = id;

        [button setTarget:self];
        [button setAction:@selector(buttonClick:)];

        if([option[@"type"] isEqual: @"MAIN"]) {
            self.mainButton = button;
        }
        else if([option[@"type"] isEqual:@"PANEL"]) {
            button.state = YES;
            [panelButtons setValue:button forKey:id];
        }
        if ([id isEqual:@"Artboard"]){
            artboradButton = button;
        }

    }
}

-(void)buttonClick:(NSButton*)button {
    NSDictionary* option = [Config MenuOption: button.identifier];
    if ([option[@"type"] isEqual:@"PANEL"]) {
        if (![self mainButton].state) {
            // 点击普通按钮时 如果总控Main未激活 则模拟激活 打开主面板
            [[self mainButton] setState:YES];
            [self.delegate toggleMain: YES];
        }
        [self.delegate togglePanel:option[@"id"] state: YES];
//        NSDictionary* info = @{
//            @"documentId": self.documentId,
//            @"panelId": option[@"id"],
//            @"states": [self panelButtonStates],
//        };
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"OPEN_PANEL" object:nil userInfo:info];
    } else if ([option[@"type"] isEqual:@"MAIN"]) {
        [self.delegate toggleMain: button.state];
    } else if ([option[@"type"] isEqual:@"WINDOW"]) {
         [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"测试版功能尚未开放，敬请期待..."]];
        [button setState:0];
    } else if([option[@"id"] isEqual:@"Artboard"]) {
        if(button.state == YES) {
            [self showAndroid];
        } else {
            [artborad close];
        }
    }
}

-(void)showAndroid {
    if (artborad) return;
    NSRect frame = NSMakeRect(100, 400, 265, 180);
    NSRect rect = [NSWindow contentRectForFrameRect:frame styleMask:NSWindowStyleMaskBorderless];
    NSWindowStyleMask mask = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable | NSWindowStyleMaskClosable;
    artborad = [[NSWindow alloc] initWithContentRect:rect styleMask:mask backing:NSBackingStoreBuffered defer:false];
    artborad.titleVisibility = NSWindowTitleVisible;
    [artborad setTitle:@"无极Skecth UIKit 画板转换工具"];
    [artborad center];
    [artborad makeKeyAndOrderFront:artborad];
    artborad.delegate = self;
    NVArtboard *c = [NVArtboard viewControllerFromNIB];
    c.window = artborad;
    artborad.contentView= c.view;
}

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp stopModal];
    [artboradButton setState:0];
    artborad = nil;
}

-(NSDictionary*)panelButtonStates {
    NSMutableDictionary *states = [[NSMutableDictionary alloc]init];

    for(NSString* key in [panelButtons allKeys]){
        NSButton *button = panelButtons[key];
        [states setValue:@(button.state) forKey:key];
    }

    return states;
}

- (NSButton*)createButton:(NSString*) name icon: (NSString *) icon {
    NSButton *button = [[NVMenuButton alloc]initWithFrame:NSMakeRect(0, 0, 40, 40)];
    NSImage *image = [NVImage imageNamed:icon];
    [image setSize: NSMakeSize(40, 40)];
    [button setImage:image];
    // [button setAlternateImage:[Util createImage:activeIconUrl withSize: NSMakeSize(40, 40)]];
    [button setBordered:NO];
    [button sizeToFit];
    [button setToolTip: name];
    [button setButtonType: NSButtonTypeMomentaryPushIn]; //NSButtonTypeMomentaryChange
    button.wantsLayer = YES;
    return button;
}

//- (void)didChangePanelState:(NSNotification*)notification{
//    if ([self.documentId isEqual:notification.userInfo[@"documentId"]]) {
//        NSString *id = notification.userInfo[@"panelId"];
//        NSButton *button = panelButtons[id];
//        if (button.state != [notification.userInfo[@"state"] intValue]) {
//            [button setNextState];
//        }
//    }
//}


+ (instancetype)viewControllerFromNIB {
    return[[Menu alloc] initWithNibName:@"Menu" bundle:[NVBundle bundlePath]];
}

@end
