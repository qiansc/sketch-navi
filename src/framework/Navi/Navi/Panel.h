//
//  PanelController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Menu.h"


// MenuControl 暴露的代理接口
@protocol PanelControlProtocol <NSObject>

@optional
-(void)viewWillLayoutSize:(NSString*)newSize;
@end


NS_ASSUME_NONNULL_BEGIN

@interface Panel : NSViewController

@property (nonatomic,weak) id<PanelControlProtocol> delegate;
@property (strong) IBOutlet NSView *view;
// Convenience Method
+ (instancetype)viewControllerFromNIB;

@end

NS_ASSUME_NONNULL_END
