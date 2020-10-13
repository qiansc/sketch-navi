//
//  Config.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/13.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Config.h"



@implementation Config

+(NSArray<NSDictionary*>*) MenuOption {
    return @[@{
        @"name": @"全部",
        @"id": @"main",
        @"gravity": @1,
        @"type": @"MAIN"
    }, @{
        @"name": @"颜色",
        @"id": @"color",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"文本",
        @"id": @"text",
        @"gravity": @1,
        @"type": @"PANEL"
    }, @{
        @"name": @"设置",
        @"id": @"mask",
        @"gravity": @3,
        @"type": @"BUTTON"
    }, @{
        @"name": @"用户",
        @"id": @"border",
        @"gravity": @3,
        @"type": @"BUTTON"
    }];
}
    // MenuOption* mainOption = [[MenuOption alloc] init];
//    NSArray<MenuOption*>* menuOptions = [[NSArray alloc]initWithObjects:
//                                         ,
//                                         nil];
@end
