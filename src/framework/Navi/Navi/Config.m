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
        @"icon": @"main",
        @"gravity": @1,
        @"type": @"MAIN"
    }, @{
        @"name": @"颜色",
        @"id": @"Color",
        @"icon": @"color",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"文本",
        @"id": @"Text",
        @"icon": @"text",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"线条",
        @"id": @"Line",
        @"icon": @"line",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"边角",
        @"id": @"Border",
        @"icon": @"border",
        @"gravity": @1,
        @"type": @"PANEL"
//    }, @{
//        @"name": @"间距",
//        @"id": @"Margin",
//        @"icon": @"margin-v",
//        @"gravity": @1,
//        @"type": @"PANEL"
//    }, @{
//        @"name": @"投影",
//        @"id": @"Shadow",
//        @"icon": @"shadow",
//        @"gravity": @1,
//        @"type": @"PANEL"
    }, @{
        @"name": @"蒙层",
        @"id": @"Mask",
        @"icon": @"mask",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"切换",
        @"id": @"Artboard",
        @"icon": @"android",
        @"gravity": @3,
        @"type": @"WINDOW"
    }, @{
        @"name": @"设置",
        @"id": @"Setting",
        @"icon": @"setting",
        @"gravity": @3,
        @"type": @"WINDOW"
    }, @{
        @"name": @"用户",
        @"id": @"User",
        @"icon": @"user",
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
