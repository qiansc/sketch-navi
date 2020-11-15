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

@protocol MenuProtocol <NSObject>

@optional
-(void)toggleMain:(BOOL) state;
@optional
-(void)togglePanel:(NSString *)panelId state:(BOOL) state;
@optional
-(void)toggleWindow:(NSString *)windowId state:(BOOL) state;

@end

@interface Menu : NSViewController 

@property (strong) IBOutlet NSStackView *headStack;
@property (nonatomic, strong) NSButton *mainButton;
@property (nonatomic, strong) NSObject<MenuProtocol> * delegate;

@end
NS_ASSUME_NONNULL_END
