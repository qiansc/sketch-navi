//
//  PanelController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Panel.h"
#import "Config.h"
#import "NVColorPanel.h"
#import "NVTextPanel.h"
#import "NVLinePanel.h"
#import "NVMaskPanel.h"

@implementation Panel

- (void)viewDidLoad {
    [super viewDidLoad];
    self.panelControllers = [[NSMutableDictionary alloc] init];
    // Menu按下传递的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePanel:) name:@"OPEN_PANEL" object:nil];
    // Menu按下传递的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePanel:) name:@"HIDE_PANEL" object:nil];
    // Panel按下传递的事件
    [self initAllPanel];
}
-  (void)viewWillLayout {
//    [self setPreferredContentSize:CGSizeMake(40, 450)];
//    self.view.window.contentMinSize = CGSizeMake(40, 450);
//    self.view.window.contentMaxSize = CGSizeMake(40, 450);
    if (self.delegate) {
        [self.delegate viewWillLayoutSize:[NSString stringWithFormat:@"%f,%f", self.view.frame.size.width, self.view.frame.size.height]];
    }
}
-(void)changePanel:(NSNotification*)notification{
    NSString *id = notification.userInfo[@"documentId"];

    NSLog(@"NAVIL openPanel => %@", notification.userInfo);
    if ([id isEqual:self.documentId]) {
        NSString *panelId = notification.userInfo[@"panelId"];
        NVPanelController *c = self.panelControllers[panelId];
        NSLog(@"NAVIL openPPPPP >> %@  %@", c,  self.panelControllers);
        if(c) {
            NSMutableDictionary *states = notification.userInfo[@"states"];
            [c setOpenStateSlient: [states[panelId] intValue]];
        }
    }
}

//-(void)didHidePanel:(NSNotification*)notification{
//    NSLog(@"NAVIL didHidePanel => %@", notification.userInfo);
//}

+ (instancetype)viewControllerFromNIB {
    // 从NIB里创建view及controller
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return[[Panel alloc] initWithNibName:@"Panel" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

- (void)layoutSection {
    NSLog(@"NAVIL %@", @"<<<");
}

// 初始化所有Panel到StackView中
- (void)initAllPanel {
    NSArray<NSDictionary*>* options = [Config MenuOptions];
    for(NSDictionary* option in options) {
        if([option[@"type"] isEqual:@"PANEL"]) {
            NSString *id = option[@"id"];
            NVPanelController *c = nil;

            if ([id isEqual: @"Color"]) {
                c = [[NVColorPanel alloc] initWithId:id];
            } else if([id isEqual: @"Text"]) {
                c = [[NVTextPanel alloc] initWithId:id];
            } else if([id isEqual: @"Line"]) {
                c = [[NVLinePanel alloc] initWithId:id];
            } else if([id isEqual: @"Mask"]) {
                c = [[NVMaskPanel alloc] initWithId:id];
            }

            if (c) {
                [self.stackView addArrangedSubview:c.view];
                c.headerView.titleLabel.stringValue = option[@"name"];
                [self.panelControllers setValue:c forKey:id];
            }

        }
    }
}

- (void)setDocumentId:(NSString*) documentId {
    self.view.identifier = [documentId stringByAppendingString:@"-navi-tools-panel"];
    _documentId = documentId;
}

+ (instancetype)generateWithDocumentId:(NSString*) documentId {
    Panel* panel = [self viewControllerFromNIB];
    [panel setDocumentId:documentId];
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFirst:) name:@"First" object:nil];
    return panel;
}

@end
