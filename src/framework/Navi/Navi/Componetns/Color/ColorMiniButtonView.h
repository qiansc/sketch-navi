//
//  ColorMiniButtonView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ButtonProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface ColorMiniButtonView : NSButton

@property (nonatomic, assign) BOOL selected; //default NO.
@property (nonatomic, assign) NSString* colorString;
@property (nonatomic) id<ButtonProtocol> delegate;

- (void)updateState;

@end



NS_ASSUME_NONNULL_END
