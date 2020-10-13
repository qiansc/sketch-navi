//
//  MenuController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Util.h"

NS_ASSUME_NONNULL_BEGIN

// MenuControl 暴露的代理接口
@protocol MenuControlProtocol <NSObject>

@optional
-(void)onButtonClick:(NSButton*)button;
-(void)viewWillLayoutSize:(NSString*)newSize;
@end

@interface Menu : NSViewController
    
    @property (nonatomic,weak) id<MenuControlProtocol> delegate;
    @property (strong) IBOutlet NSView *view;
    @property (strong) IBOutlet NSStackView *headStack;
    @property (nonatomic, weak) NSButton *mainButton;

    // Convenience Method
    + (instancetype)viewControllerFromNIB;
    - (void)viewWillTransitionToSize:(NSSize)newSize;

@end
NS_ASSUME_NONNULL_END
