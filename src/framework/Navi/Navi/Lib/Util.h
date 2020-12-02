//
//  Util.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (NSImage*)createImage:(NSURL*) imageURL withSize:(NSSize) size;
+ (NSBox*)separtorBox;

+ (void)fillSuperview:(NSView*)view;

+ (void)position:(MSLayer*)layer at:(CGPoint) point;
+ (CGPoint)parentOffsetInArtboard:(MSLayer*)layer;

+ (void)message:(NSString *) string;

@end

NS_ASSUME_NONNULL_END
