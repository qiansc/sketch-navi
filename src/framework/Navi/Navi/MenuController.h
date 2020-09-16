//
//  MenuController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuController : NSViewController
    @property (strong) IBOutlet NSView *view;
    // Convenience Method
    + (instancetype)viewControllerFromNIB;
@end

NS_ASSUME_NONNULL_END
