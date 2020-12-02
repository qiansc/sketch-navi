//
//  NVURL.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/2.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NVCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface NVURL : NSObject

+(void)request:(NSDictionary*)option completionHandler:NVCompletionHandler;

@end

NS_ASSUME_NONNULL_END
