//
//  MenuController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Headers/RezieseProtocol.h"
#import "Util.h"

NS_ASSUME_NONNULL_BEGIN

@interface Menu : NSViewController
    
    @property (nonatomic,weak) id<ResizeProtocol> delegate;
    @property (strong) IBOutlet NSView *view;
    @property (strong) IBOutlet NSStackView *headStack;
    // Convenience Method
    + (instancetype)viewControllerFromNIB;
    - (void)viewWillTransitionToSize:(NSSize)newSize;
@end

NS_ASSUME_NONNULL_END
