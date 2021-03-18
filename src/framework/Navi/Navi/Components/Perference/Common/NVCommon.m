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
#import "Util.h"

@interface NVCommon ()

@end

@implementation NVCommon

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.sourceButton setTarget:self];
    [self.sourceButton setAction:@selector(sourceChanged:)];
    
    [self.groupButton setTarget:self];
    [self.groupButton setAction:@selector(groupChanged:)];
    
    [self.versionButton setTarget:self];
    [self.versionButton setAction:@selector(versionChanged:)];
    
    [self.updateButton setTarget:self];
    [self.updateButton setAction:@selector(updateButtonClicked:)];

    
    [self.unitButton setTarget:self];
    [self.unitButton setAction:@selector(unitChanged:)];
    
    self.infoView.wantsLayer = YES;
    self.infoView.layer.backgroundColor = [NSColor unemphasizedSelectedContentBackgroundColor].CGColor;
}

- (void)updateView {
    NSDictionary *data = [NVUserData userData];
    NSString *version = data[@"version"];
    NSString *group = data[@"group"];
    NSString *source = data[@"source"];
    if (source == nil) source = data[@"source"][0][@"id"];
    
    NSDictionary* config = [Util loadConfig];
    
    [self updateButton:self.sourceButton withItems: config[@"sourceList"]];
    NSDictionary* sourceConfig = [self getItemWithID:source from:config[@"sourceList"]];
    [self.sourceButton selectItemWithTitle:sourceConfig[@"label"]];

    if (group == nil) group = sourceConfig[@"groupList"][0][@"id"];
    if (version == nil) version = [sourceConfig[@"specVersions"] lastObject];
    [self updateButton:self.groupButton withItems: sourceConfig[@"groupList"]];
    NSDictionary* groupConfig = [self getItemWithID:group from:sourceConfig[@"groupList"]];
    [self.groupButton selectItemWithTitle:groupConfig[@"label"]];
    
    [self updateButton:self.versionButton withList: sourceConfig[@"specVersions"]];
    [self.versionButton selectItemWithTitle:version];
    self.infoField.stringValue = @"";
    [self.infoView setHidden:YES];
    [self updateDate];
    
}


-(void)updateButton:(NSPopUpButton*) button withItems:(NSArray<NSDictionary*> *) items {
    [button removeAllItems];
    for(NSDictionary* item in items) {
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        menuItem.title = item[@"label"];
        menuItem.identifier = item[@"id"];
        [button.menu addItem:menuItem];
    }
}
-(void)updateButton:(NSPopUpButton*) button withList:(NSArray<NSString*> *) items {
    [button removeAllItems];
    for(NSString* item in items) {
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        menuItem.title = item;
        menuItem.identifier = item;
        [button.menu addItem:menuItem];
    }
}

-(NSDictionary*)getItemWithID:(NSString*) identifier from:(NSArray<NSDictionary*>*) items {
    for(NSDictionary* item in items) {
        if ([item[@"id"] isEqualToString:identifier]) {
            return item;
        }
    }
    return nil;
}

-(void)updateDate {
    NSDate *date = [NVSpec updateTime];
    if (date) {
        NSDateFormatter *formatter =[NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.updateField.stringValue =[formatter stringFromDate:date];
    } else {
        self.updateField.stringValue = @"暂无更新日期";
    }
}

-(void)sourceChanged:(NSButton*) sender {
    NSMutableDictionary *data = [[NVUserData userData] mutableCopy];
    data[@"source"] = self.sourceButton.selectedItem.identifier;
    data[@"group"] = nil;
    data[@"version"] = nil;
    [NVUserData saveUserData:data];
    [self updateView];
    [self groupChanged:sender];
    [self versionChanged:sender];
    
    
}

-(void)groupChanged:(NSButton*) sender {
    NSMutableDictionary *data = [[NVUserData userData] mutableCopy];
    data[@"group"] = self.groupButton.selectedItem.identifier;
    [NVUserData saveUserData:data];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:nil];
    self.infoField.stringValue = [NSString stringWithFormat: @"已经切换到 %@ - %@ 业务线！", self.sourceButton.selectedItem.title, self.groupButton.selectedItem.title];
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


-(void)unitChanged:(NSButton*) sender {
    NSMutableDictionary *data = [[NVUserData userData] mutableCopy];
    data[@"unit"] = self.unitButton.selectedItem.identifier;
    [NVUserData saveUserData:data];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SPEC_UPDATE" object:nil userInfo:nil];
    self.infoField.stringValue = [NSString stringWithFormat: @"使用单位 %@ ", self.unitButton.selectedItem.title];
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
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDate) userInfo:nil repeats:NO];
}

@end
