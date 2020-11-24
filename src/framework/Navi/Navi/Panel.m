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
#import "NVFontPanel.h"
#import "NVWeightPanel.h"
#import "NVLinePanel.h"
#import "NVMaskPanel.h"
#import "NVBorderPanel.h"
#import "NVGridPanel.h"
#import "NVMarginPanel.h"
#import "NVVertPanel.h"
#import "NVHoriPanel.h"
#import "NVIconPanel.h"
#import "MSDocument.h"
#import "NVBundle.h"
#import "NVSource.h"
#import "NVColor.h"
#import "NVShadowPanel.h"

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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePanel:) name:@"OPEN_PANEL" object:nil];
    // Menu按下传递的事件
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePanel:) name:@"HIDE_PANEL" object:nil];
    // Panel按下传递的事件
    [self.stackView setSpacing:0];
    [self initAllPanel];
    self.searchField.delegate = self;
    self.searchField.placeholderString = @"全部资源";
    [self.semanticButton setTarget:self];
    [self.semanticButton setAction:@selector(changeSemanticMode:)];

//    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyUp handler:^NSEvent*(NSEvent* event){
//        NSLog(@"NAVIL %@", event);
//        return event;
//    }];
}

-(void)changeSemanticMode:(NSButton*) button {
    for(NSObject<NVSource> * c in [panelSources allValues]) {
        [c setSemanticMode:button.state];
    }
}

-(void)controlTextDidChange:(NSNotification *)obj{
    locked = YES;
    for(NSObject<NVSource> *source in [panelSources allValues]) {
        if (source) {
            [source setQuery: self.searchField.stringValue];
        }
    }
}

/* 初始化所有Panel到StackView中 */
- (void)initAllPanel {
    NSArray<NSDictionary*>* options = [Config MenuOptions];
    for(NSDictionary* option in options) {
        if([option[@"type"] isEqual:@"PANEL"]) {
            NSString *id = option[@"id"];
            NVPanel *c = nil;

            if ([id isEqual: @"Color"]) {
                c = [[NVColorPanel alloc] initWithId:id];
//            } else if([id isEqual: @"Text"]) {
//                c = [[NVTextPanel alloc] initWithId:id];
            } else if([id isEqual: @"Font"]) {
                c = [[NVFontPanel alloc] initWithId:id];
            } else if([id isEqual: @"Weight"]) {
                c = [[NVWeightPanel alloc] initWithId:id];
            } else if([id isEqual: @"Line"]) {
                c = [[NVLinePanel alloc] initWithId:id];
            } else if([id isEqual: @"Mask"]) {
                c = [[NVMaskPanel alloc] initWithId:id];
            } else if([id isEqual: @"Border"]) {
                c = [[NVBorderPanel alloc] initWithId:id];
            } else if([id isEqual: @"Grid"]) {
                c = [[NVGridPanel alloc] initWithId:id];
            } else if([id isEqual: @"Vert"]) {
                c = [[NVVertPanel alloc] initWithId:id];
            } else if([id isEqual: @"Hori"]) {
                c = [[NVHoriPanel alloc] initWithId:id];
            } else if([id isEqual: @"Margin"]) {
                c = [[NVMarginPanel alloc] initWithId:id];
            } else if ([id isEqual:@"Shadow"]) {
                c = [[NVShadowPanel alloc] initWithId:id];
            } else if ([id isEqual:@"Icon"]) {
                c = [[NVIconPanel alloc] initWithId:id];
            }
            if (c) {
                [self.stackView addArrangedSubview:c.view];
                c.headerView.controller.titleLabel.stringValue = option[@"name"];
                c.panelDelegate = self;
                [panelControllers setValue:c forKey:id];
                NSObject<NVSource> *source = [c generatePanelSource];
                [panelSources setValue:source forKey:id];

            }

        }
    }
}

-(void)scrollToPanel:(NSString *)panelId {
    NVPanel *c = panelControllers[panelId];
    if(c) {
        [self.scrollView.contentView scrollPoint: CGPointMake(0, self.stackView.frame.size.height - c.view.frame.origin.y - c.view.frame.size.height)];
        [c setStateSlient:YES];
    }
}

/** delegate 响应subview nvpanel的状态变化 */
- (void)panel:(NSString *)panelId changeState:(NSControlStateValue)state {
    NVPanel *c = panelControllers[panelId];
    if (c) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DID_TOOGLE_PANEL" object:nil userInfo:@{
                @"documentId": self.documentId,
                @"state": @(state),
                @"panelId": panelId
            }];
    }

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
    for(NVPanel *c in [panelControllers allValues]){
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

    return[[Panel alloc] initWithNibName:@"Panel" bundle:[NVBundle bundlePath]];
    // return [[MenuController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}


@end
