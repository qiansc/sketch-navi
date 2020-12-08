//
//  NVSpec.h
//  Navi
//
//  Created by QIANSC on 2020/12/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVSpec : NSObject

+(BOOL)fetch:(NSString*) version;
+(BOOL)fetchAllVersion;
+(NSDate*)updateTime;

-(instancetype)load;
-(NSDictionary*)getSpec;


@end

NS_ASSUME_NONNULL_END
