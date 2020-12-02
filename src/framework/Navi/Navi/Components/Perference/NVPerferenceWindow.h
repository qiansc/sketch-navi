//
//  NVPerferenceWindow.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/1.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVPerferenceWindow : NSWindow<NSWindowDelegate>

+(instancetype)initFromNIB;

- (void)toogle;

@end

NS_ASSUME_NONNULL_END
