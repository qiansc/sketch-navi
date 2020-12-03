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
    NSURL *path = [dir URLByAppendingPathComponent:@"data.usr" isDirectory: NO];
    NSLog(@"### path %@", [path absoluteString]);
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[path absoluteString]]) {
        return path;
    }
    NSData *data = [@"" dataUsingEncoding: NSUTF8StringEncoding];
    BOOL ret = [fm createFileAtPath:[path absoluteString] contents:data attributes:nil];
    NSLog(@"### ret %hhd", ret);
    if (ret)
        return path;
    return nil;
}

@end
