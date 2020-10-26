//
//  PanelController.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Panel.h"
#import "Config.h"
#import "NVSource.h"
#import "NVColorPanel.h"
#import "NVTextPanel.h"
#import "NVLinePanel.h"
#import "NVMaskPanel.h"
#import "MSDocument.h"

@implementation Panel {
    int limitWidth;
    NSMutableDictionary* panelControllers;
    NSMutableDictionary* panelSources;
    BOOL locked;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    panelControllers = [[NSMutableDictionary alloc] init];
    panelSources = [[NSMutableDictionary alloc] init];
    // Menu按下传递的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePanel:) name:@"OPEN_PANEL" object:nil];
    // Menu按下传递的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePanel:) name:@"HIDE_PANEL" object:nil];
    // Panel按下传递的事件
    [self initAllPanel];
    self.searchField.delegate = self;
    self.searchField.placeholderString = @"全部资源";

//    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyUp handler:^NSEvent*(NSEvent* event){
//        NSLog(@"NAVIL %@", event);
//        return event;
//    }];
}

-(void)controlTextDidChange:(NSNotification *)obj{
    for(NSObject<NVSource> *source in [panelSources allValues]) {
        if (source) {
            [source setQuery: self.searchField.stringValue];
        }
    }
}
//-(void)controlTextDidBeginEditing:(NSNotification *)obj{
//    if (self.searchField.placeholderString
//}
//-(void)controlTextDidEndEditing:(NSNotification *)obj{
//
//}

/* 初始化所有Panel到StackView中 */
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
                c.panelDelegate = self;
                [panelControllers setValue:c forKey:id];
                [panelSources setValue:[c generatePanelSource] forKey:id];

            }

        }
    }
}

/* OPEN_PANEL Hanlder */
-(void)changePanel:(NSNotification*)notification{
    NSString *id = notification.userInfo[@"documentId"];
    if ([id isEqual:self.documentId]) {
        NSString *panelId = notification.userInfo[@"panelId"];
        NVPanelController *c = panelControllers[panelId];
        if(c) {
            NSMutableDictionary *states = notification.userInfo[@"states"];
            [c setOpenStateSlient: [states[panelId] intValue]];
        }
    }
}

/*  protocol trigger 用于通知superview 自身viewWillLayout */
-  (void)viewWillLayout {
    [super viewWillLayout];
    NSRect frame = self.scrollView.documentView.frame;
    self.scrollView.documentView.frame = NSMakeRect(frame.origin.x, frame.origin.y, 240, frame.size.height);
    if (self.delegate) {
        [self.delegate viewWillLayoutSize:[NSString stringWithFormat:@"%f,%f", self.view.frame.size.width, self.view.frame.size.height]];
    }
}

/** delegate 响应subview nvpanel的状态变化 */
- (void)panel:(NSString *)panelId changeState:(NSControlStateValue)state {
    NVPanelController *c = panelControllers[panelId];
    if (c) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DID_TOOGLE_PANEL" object:nil userInfo:@{
                @"documentId": self.documentId,
                @"state": @(state),
                @"panelId": panelId
            }];
    }

}

/** delegate 响应subview panelDidResize变化 */
- (void)panelDidResize:(NSString *)panelId{
    // Solution.001 解决NVPanel变化时，滚动条消失，但docuemntView没重绘显示不完全问题
    if (locked) return;
    locked = YES;
    self.view.frame = NSMakeRect(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width + 1, self.view.frame.size.height);
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(fitResize) userInfo:nil repeats:NO];

}
// 触发重绘 副作用抖动后续重构
-(void)fitResize{
    self.view.frame = NSMakeRect(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width - 1, self.view.frame.size.height);
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(endFit) userInfo:nil repeats:NO];
}
-(void)endFit{
    locked = NO;
}


/* 更新规范接口 */
- (void)updateSpec:(NSDictionary *) specs{
    for(NSString * key in [specs allKeys]) {
        NSObject<NVSource> *source = panelSources[key];
        if (source) {
            [source update:specs[key]];
        }
    }
}

- (void)selectionChange {
    MSDocument *document = [[NSDocumentController sharedDocumentController] currentDocument];
    for(NVPanelController *c in [panelControllers allValues]){
        [c selectionChange: document.selectedLayers];
    }
}

+ (instancetype)generateWithDocumentId:(NSString*) documentId {
    Panel* panel = [self viewControllerFromNIB];
    panel.view.identifier = [documentId stringByAppendingString:@"-navi-tools-panel"];
    panel.documentId = documentId;
    // [panel setDocumentId:documentId];
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFirst:) name:@"First" object:nil];
    return panel;
}

+ (instancetype)viewControllerFromNIB {
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];

    return[[Panel alloc] initWithNibName:@"Panel" bundle:resourceBundlePath];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}


@end
