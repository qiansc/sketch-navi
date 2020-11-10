//
//  DataChangeProtocol.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/25.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol  DataChangeProtocol <NSObject>

@optional
- (void)colorChange:(NSString *) colorCode;

@end

NS_ASSUME_NONNULL_END
