//
//  NVCommon.m
//  Navi
//
//  Created by QIANSC on 2020/12/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCommon.h"
#import "NVUserData.h"
#import "NVSpec.h"

@interface NVCommon ()

@end

@implementation NVCommon

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.groupButton setTarget:self];
    [self.groupButton setAction:@selector(groupChanged:)];
    
    [self.versionButton setTarget:self];
    [self.versionButton setAction:@selector(versionChanged:)];
    
    [self.updateButton setTarget:self];
    [self.updateButton setAction:@selector(updateButtonClicked:)];

    self.infoView.wantsLayer = YES;
    self.infoView.layer.backgroundColor = [NSColor unemphasizedSelectedContentBackgroundColor].CGColor;
}

- (void)updateView {
    NSDictionary *data = [NVUserData userData];
    NSString *version = data[@"version"];
    NSString *group = data[@"group"];
    
    if (version) {
        [self.versionButton selectItemWithTitle:version];
    }
    if (group) {
        for(NSMenuItem *item in self.groupButton.itemArray) {
            if ([group isEqualToString:item.identifier]) {
                [self.groupButton selectItem:item];
            }
        }
    }
    self.infoField.stringValue = @"";
    [self.infoView setHidden:YES];
}

-(void)groupChanged:(NSButton*) sender {
    NSMutableDictionary *data = [[NVUserData userData] mutableCopy];
    data[@"group"] = self.groupButton.selectedItem.identifier;
    [NVUserData saveUserData:data];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:nil];
    self.infoField.stringValue = [NSString stringWithFormat: @"已经切换到 %@ 业务线！", self.groupButton.selectedItem.title];
    [self.infoView setHidden:NO];
}

-(void)versionChanged:(NSButton*) sender {
    NSMutableDictionary *data = [[NVUserData userData] mutableCopy];
    data[@"version"] = self.versionButton.selectedItem.title;
    [NVUserData saveUserData:data];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:nil];
    self.infoField.stringValue = [NSString stringWithFormat: @"已经切换到 %@ 版本！", self.versionButton.selectedItem.title];
    [self.infoView setHidden:NO];
}

-(void)updateButtonClicked:(NSButton*) sender{
    [self.updateButton setEnabled:NO];
    self.infoField.stringValue = @"正在更新数据，请稍候...";
    [self.infoView setHidden:NO];
    BOOL specRet = [NVSpec fetchAllVersion];
    if (specRet) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:nil];
        self.infoField.stringValue = @"数据同步成功，插件已经更新！";
    } else {
       self.infoField.stringValue = @"更新失败，请稍后重试...";
    }
    [self.updateButton setEnabled:YES];
}

@end
