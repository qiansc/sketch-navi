//
//  MenuController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuController : NSViewController
    
    @property (nonatomic,weak) id<MenuProtocol> delegate;
    @property (strong) IBOutlet NSView *view;
    // Convenience Method
    + (instancetype)viewControllerFromNIB;
    - (void)viewWillTransitionToSize:(NSSize)newSize;
@end

NS_ASSUME_NONNULL_END
