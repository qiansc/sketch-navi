//
//  NVArtboard.h
//  Navi
//
//  Created by QIANSC on 2020/10/26.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVArtboard : NSViewController

+ (instancetype)viewControllerFromNIB;
@property (strong) IBOutlet NSButton *confirmButton;
@property (strong) IBOutlet NSButton *closeButton;
@property (nonatomic, strong) NSWindow *window;
//-(void)closeWindow:(NSButton*) button;
//-(void)confirmInfo:(NSButton*) button;
@end

NS_ASSUME_NONNULL_END
