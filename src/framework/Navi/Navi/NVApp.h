//
//  NVApp.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVApp : NSObject

+(instancetype)prepareInit;
+(instancetype)currentApp;
-(void)startUp;


@property (nonatomic,strong) NSString *documentID;



@end

NS_ASSUME_NONNULL_END
