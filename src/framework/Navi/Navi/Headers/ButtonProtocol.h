//
//  ButtonProtocol.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/22.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ButtonProtocol <NSObject>

@optional

- (void)mouseDown:(NSEvent *)event on:(NSButton *)view;
- (void)mouseUp:(NSEvent *)event on:(NSButton *)view;

@end

NS_ASSUME_NONNULL_END
