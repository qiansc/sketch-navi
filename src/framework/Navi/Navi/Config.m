//
//  Config.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/13.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Config.h"

@implementation Config

+(NSArray<NSDictionary*>*) MenuOptions {
    return @[@{
        @"name": @"全部",
        @"id": @"Main",
        @"icon": @"Main",
        @"gravity": @1,
        @"type": @"MAIN"
    }, @{
        @"name": @"颜色",
        @"id": @"Color",
        @"icon": @"Color",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"文本",
        @"id": @"Text",
        @"icon": @"Text",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"线条",
        @"id": @"Line",
        @"icon": @"Line",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"边角",
        @"id": @"Border",
        @"icon": @"Border",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"栅格",
        @"id": @"Grid",
        @"icon": @"Layout",
        @"gravity": @1,
        @"type": @"PANEL"
//    }, @{
//        @"name": @"间距",
//        @"id": @"Margin",
//        @"icon": @"Margin-H",
//        @"gravity": @1,
//        @"type": @"PANEL"
    }, @{
        @"name": @"上下间距",
        @"id": @"Vert",
        @"icon": @"Margin-V",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"水平间距",
        @"id": @"Hori",
        @"icon": @"Margin-H",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"投影",
        @"id": @"Shadow",
        @"icon": @"Shadow",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"蒙层",
        @"id": @"Mask",
        @"icon": @"Mask",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"切换",
        @"id": @"Artboard",
        @"icon": @"Android",
        @"gravity": @3,
        @"type": @"WINDOW"
    }, @{
        @"name": @"设置",
        @"id": @"Setting",
        @"icon": @"Setting",
        @"gravity": @3,
        @"type": @"WINDOW"
    }, @{
        @"name": @"用户",
        @"id": @"User",
        @"icon": @"User",
        @"gravity": @3,
        @"type": @"WINDOW"
    }];
}

+(NSDictionary*) MenuOption:(NSString*) id {
    for (NSDictionary* option in [self MenuOptions]) {
        if([option[@"id"] isEqual:id]) {
            return option;
        }
    }
    return nil;
}

// MenuOption* mainOption = [[MenuOption alloc] init];
//    NSArray<MenuOption*>* menuOptions = [[NSArray alloc]initWithObjects:
//                                         ,
//                                         nil];
@end
