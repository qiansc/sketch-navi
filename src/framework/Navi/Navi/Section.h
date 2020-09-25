//
//  Section.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ColorPanelView.h"

NS_ASSUME_NONNULL_BEGIN

@interface Section : NSViewController

@property (strong) IBOutlet NSView *view;
@property (strong) IBOutlet NSButton *pluginTitle;
@property (strong) IBOutlet ColorPanelView * colorPanelView;

+ (instancetype)viewControllerFromNIB;

@end

NS_ASSUME_NONNULL_END
