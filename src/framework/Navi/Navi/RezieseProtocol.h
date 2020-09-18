//
//  MenuProtocol.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/17.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ResizeProtocol <NSObject>

@optional
-(void)viewWillLayoutSize:(NSString*)newSize;

@end

NS_ASSUME_NONNULL_END
