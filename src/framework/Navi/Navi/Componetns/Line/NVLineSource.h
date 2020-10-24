//
//  NVLineSource.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <NVSource.h>

NS_ASSUME_NONNULL_BEGIN

struct NVLineSpec {
    NSString *weight; // 线条粗细
    NSString *specCode; // 编码
    NSString *desc; // 语义化
};

typedef struct NVLineSpec NVLineSpec;

@interface NVLineSource : NSObject<NVSource>

- (NVLineSpec)getSpecAt:(NSIndexPath *) indexPath;

@end

NS_ASSUME_NONNULL_END
