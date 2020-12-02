//
//  NVURL.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/2.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVURL.h"

@implementation NVURL

+(void)request:(NSDictionary*)option completionHandler:(NVCompletionHandler) handler{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/curl"];
    if (option[@"cookie-jar"]) {
        [task setArguments:@[option[@"url"], @"-b", option[@"cookie-jar"], @"-c", option[@"cookie-jar"]]];
    } else {
        [task setArguments:@[option[@"url"]]];
    }
    NSPipe *outputPipe = [NSPipe pipe];
    [task setStandardOutput:outputPipe];
    [task launch];
    NSData * responseData = [[outputPipe fileHandleForReading] readDataToEndOfFile];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if (responseString) {
        handler(responseData, nil, nil);
        // [self performSelector:action withObject:responseString];
    } else {
        // self.infoField.stringValue = @"无法连接至账户服务器，请检查网络状态后重试！";
        // [self.infoView setHidden:NO];
        NSError *err = [[NSError alloc]init];
        handler(nil, nil, err);
    }
}



@end
