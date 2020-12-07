//
//  NVUserData.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/12/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVUserData.h"
#import "Util.h"

@implementation NVUserData {
    
}


+(NSURL*)cookieFileURL {
    NSURL *dir = [Util applicationDataDirectory];
    if (dir == nil) return nil;
    NSURL *url = [dir URLByAppendingPathComponent:@"c.data" isDirectory: NO];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:url.path]) {
        return url;
    }
    BOOL ret = [fm createFileAtPath:url.path contents:nil attributes:nil];
    if (ret)
        return url;
    return nil;
}

+(NSURL*)userFileURL {
    NSURL *dir = [Util applicationDataDirectory];
    if (dir == nil) return nil;
    NSURL *url = [dir URLByAppendingPathComponent:@"u.data" isDirectory: NO];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:url.path]) {
        return url;
    }
    BOOL ret = [fm createFileAtPath:url.path contents:nil attributes:nil];
    if (ret)
        return url;
    return nil;
}

+(NSDictionary*)userData {
    NSDictionary *data = @{};
    NSURL *url = [NVUserData userFileURL];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:url.path]) {
        NSData *json = [NSData dataWithContentsOfURL:url];
        json = [json initWithBase64EncodedData:json options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        NSError *err;
        data = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&err];
        return data;
    }
    return data;
}

+(BOOL)saveUserData:(NSDictionary*) data {
    NSURL *url = [NVUserData userFileURL];
    NSData *json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    json = [json base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    BOOL ret = [json writeToURL:url atomically:YES];
    return ret;
}

@end
