//
//  MenuView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Menu.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVMenuView : NSView

@property (nonatomic, strong) Menu *controller;

@end

NS_ASSUME_NONNULL_END
