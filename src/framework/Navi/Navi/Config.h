//
//  Config.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/13.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Config : NSObject

    +(NSArray<NSDictionary*>*) MenuOptions;
    +(NSDictionary*) MenuOption:(NSString*) id;

@end

NS_ASSUME_NONNULL_END
