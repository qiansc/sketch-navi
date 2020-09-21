//
//  ColorMiniPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorMiniPanel : NSViewController

@property (strong) IBOutlet NSView *view;

+ (instancetype)viewControllerFromNIB;

@end

NS_ASSUME_NONNULL_END
