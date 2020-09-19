//
//  PanelController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Headers/RezieseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Panel : NSViewController

@property (nonatomic,weak) id<ResizeProtocol> delegate;
@property (strong) IBOutlet NSView *view;
// Convenience Method
+ (instancetype)viewControllerFromNIB;

@end

NS_ASSUME_NONNULL_END
