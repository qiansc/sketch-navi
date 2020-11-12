//
//  NVAppCache.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSDocument.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVAppCache : NSObject

+(void)cacheApp:(id) app with:(MSDocument*) document;
+(id)getAppWith:(MSDocument*) document;

@end

NS_ASSUME_NONNULL_END
