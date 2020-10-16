//
//  Util.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (NSImage*)createImage:(NSURL*) imageURL withSize:(NSSize) size;
+ (NSBox*)separtorBox;
@end

NS_ASSUME_NONNULL_END
