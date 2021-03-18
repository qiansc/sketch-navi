//
//  NVSpec.m
//  Navi
//
//  Created by QIANSC on 2020/12/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVSpec.h"
#import "NVUserData.h"
#import "NVURL.h"
#import "Util.h"

static int specRequestThread;

@implementation NVSpec {
    NSDictionary *config;
    NSArray *colorSpec;
    NSArray *spec;
}


+(BOOL)fetchColorSpecOnSource:(NSDictionary*) sourceConfig version:(NSString*) version{
    NSString *cookieFile = [NVUserData cookieFileURL].path;
    NSDictionary *config = [Util loadConfig];
    if (config == nil) return NO;
    NSMutableArray *groupIds = [NSMutableArray new];
    for(NSDictionary* groupConfig in sourceConfig[@"groupList"]) {
        [groupIds addObject:groupConfig[@"id"]];
    }
    
    NSString *tpl = [NSString stringWithFormat:@"%@%@", config[@"host"], config[@"specColorAPI"]];
    NSString *url = [NSString stringWithFormat:tpl,
                     sourceConfig[@"id"],
                     [version isEqualToString:@"默认"] ? @"" : version,
                     [groupIds componentsJoinedByString:@"-"]];

    [NVSpec addRequestThread];
    NSLog(@"### fetch color spec: %@", url);
    [NVURL request:@{
        @"url": url,
        @"cookie-jar": cookieFile
    } completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"### fetchColorSpec Error %@ Url %@ data %@", error, url, data);
        } else {
            NSURL *dir = [Util applicationDataDirectory];
            NSString *file = [NSString stringWithFormat:@"spec_color_%@_%@.json", sourceConfig[@"id"], version];
            NSURL *url = [dir URLByAppendingPathComponent:file isDirectory: NO];
            [data writeToURL:url atomically:YES];
            [NVSpec resolveRequestThread];
        }
    }];
    return YES;
}

+(BOOL)fetchSpecOnSource:(NSDictionary*) sourceConfig version:(NSString*) version{
    NSString *cookieFile = [NVUserData cookieFileURL].path;
    NSDictionary *config = [Util loadConfig];
    if (config == nil) return NO;
    NSString *tpl = [NSString stringWithFormat:@"%@%@", config[@"host"], config[@"specAPI"]];
    NSString *url = [NSString stringWithFormat:tpl,
                     sourceConfig[@"id"],
                     [version isEqualToString:@"默认"] ? @"" : version];
    [NVSpec addRequestThread];
    NSLog(@"### fetch spec: %@", url);
    [NVURL request:@{
        @"url": url,
        @"cookie-jar": cookieFile
    } completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"### fetchSpec Error %@  Url %@  data %@", error, url, data);
        } else {
            NSURL *dir = [Util applicationDataDirectory];
            NSString *file = [NSString stringWithFormat:@"spec_%@_%@.json", sourceConfig[@"id"], version];
            NSURL *url = [dir URLByAppendingPathComponent:file isDirectory: NO];
            [data writeToURL:url atomically:YES];
            [NVSpec resolveRequestThread];
            //
        }
    }];
    return YES;
}

+ (void)addRequestThread {
    specRequestThread++;
}

+ (void)resolveRequestThread {
    specRequestThread--;
}

+(BOOL)fetchOnSource:(NSDictionary*) sourceConfig at:(NSString*) version{
    if ([NVSpec fetchSpecOnSource: sourceConfig version:version] &&
        [NVSpec fetchColorSpecOnSource:sourceConfig version:version]) {
        return YES;
    }
    return NO;
}

+(BOOL)fetchAllVersion{
    BOOL rs = YES;
    NSDictionary *config = [Util loadConfig];
    
    for(NSDictionary* sourceConfig in config[@"sourceList"]) {
        NSArray *versions = sourceConfig[@"specVersions"];
        if (versions == nil || [versions count] == 0) {
            versions= @[@""];
        }
        [NVSpec addRequestThread];
        for(NSString *version in versions) {
            if(![NVSpec fetchOnSource: sourceConfig at:version]) {
                rs = NO;
            }
        }
        [NVSpec resolveRequestThread];
    }
    return rs;
}

+(NSDate*)updateTime {
    NSDictionary *config = [Util loadConfig];
    NSDictionary *sourceConfig = [config[@"sourceList"] firstObject];
    // NSDictionary *groupConfig = [sourceConfig[@"groupList"] firstObject];
    NSArray *version = [sourceConfig[@"specVersions"] lastObject];

    NSURL *dir = [Util applicationDataDirectory];
    NSString *file = [NSString stringWithFormat:@"spec_%@_%@.json", sourceConfig[@"id"], version];
    NSURL *url = [dir URLByAppendingPathComponent:file isDirectory: NO];
    NSFileManager *fm =[NSFileManager defaultManager];
    NSError *err;
    NSDictionary *attr =[fm attributesOfItemAtPath:url.path error:&err];
    NSDate *createDate = [attr objectForKey:NSFileCreationDate];
    if(err) return nil;
    return createDate;
}

-(instancetype)init{
    config = [Util loadConfig];
    return self;
}

-(instancetype)load{
    NSString *version = [NVUserData userData][@"version"];
    if (!version) {
        version = [config[@"specVersions"] lastObject];
    }
    [self load: version];
    return self;
}

-(instancetype)load:(NSString*) version {
    NSString *sourceId = [NVUserData userData][@"source"];
    NSURL *dir = [Util applicationDataDirectory];
    NSString *colorFile = [NSString stringWithFormat:@"spec_color_%@_%@.json", sourceId, version];
    NSString *specFile = [NSString stringWithFormat:@"spec_%@_%@.json", sourceId, version];
    NSURL *colorUrl = [dir URLByAppendingPathComponent:colorFile isDirectory: NO];
    NSURL *specUrl = [dir URLByAppendingPathComponent:specFile isDirectory: NO];
    NSFileManager *fm = [NSFileManager defaultManager];
    // NSLog(@"### load path colorUrl.path: %@ specUrl: %@ ", colorUrl.path, specUrl.path);
    if ([fm fileExistsAtPath:colorUrl.path] && [fm fileExistsAtPath:specUrl.path]) {
        NSData * colorData = [NSData dataWithContentsOfURL:colorUrl];
        NSData * specData = [NSData dataWithContentsOfURL:specUrl];
        colorSpec = [NSJSONSerialization JSONObjectWithData:colorData options:NSJSONReadingMutableContainers error:nil][@"data"];
        spec = [NSJSONSerialization JSONObjectWithData:specData options:NSJSONReadingMutableContainers error:nil][@"data"];
        
        NSString *groupId = [NVUserData userData][@"group"];
        NSDictionary *config = [Util loadConfig];
        NSString *group;
        for(NSDictionary *sourceConfig in config[@"sourceList"]) {
            if ([sourceConfig[@"id"] isNotEqualTo:sourceId]) continue;
            for(NSDictionary *groupConfig in sourceConfig[@"groupList"]) {
                if ([groupConfig[@"id"] isEqualToString:groupId]) {
                    group = groupConfig[@"label"];
                }
            }
        }
        
        // NSLog(@"### load data group: %@ colorData: %@, specData: %@", group, colorSpec, spec);
        NSMutableArray *arr= [NSMutableArray new];
        int index = 0;
        for(NSDictionary* item in colorSpec) {
            if ([item[@"cline"] isNotEqualTo:group]) continue;
            NSDictionary *s = [item mutableCopy];
            [s setValue:@(index) forKey:@"index"];
            index ++;
            [arr addObject:s];
            
        }
        colorSpec = arr;
        
        arr= [NSMutableArray new];
        index = 0;
        for(NSDictionary* item in spec) {
            if ([item[@"cline"] isNotEqualTo:group]) continue;
            NSDictionary *s = [item mutableCopy];
            [s setValue:@(index) forKey:@"index"];
            index ++;
            [arr addObject:item];
        }
        spec = arr;
        
    } else {
        colorSpec = @[];
        spec = @[];
    }

    return self;
}

- (NSArray*)getColorSpec {
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *exist = [NSMutableDictionary new];
    for(NSDictionary *item in colorSpec) {
        if (!item[@"cnum"]) continue;
        if (exist[item[@"cnum"]]) continue;
        NSDictionary *s = [item mutableCopy];
        [s setValue:@[s[@"cclass"],s[@"cmeaning"]] forKey:@"dim"];
        if ([s[@"cmeaning"] containsString:@"边"] || [s[@"cmeaning"] containsString:@"线"] || [s[@"cclass"] containsString:@"边"] || [s[@"cclass"] containsString:@"线"]) {
            [s setValue:@YES forKey:@"borderMode"];
            [s setValue:@NO forKey:@"fillMode"];
        } else {
            [s setValue:@NO forKey:@"borderMode"];
            [s setValue:@YES forKey:@"fillMode"];
        }
        
        if ([s[@"cmeaning"] containsString:@"字"] || [s[@"cclass"] containsString:@"字"]) {
            [s setValue:@"Text" forKey:@"shapeMode"];
            [s setValue:@NO forKey:@"borderMode"];
            [s setValue:@YES forKey:@"fillMode"];
        } else {
            [s setValue:@"Others" forKey:@"shapeMode"];
        }
        [exist setValue:@YES forKey:s[@"cnum"]];
        [arr addObject:s];
    }
    return arr;
}




- (NSArray*)getSpecWith:(NSString*) prefix {
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *exist = [NSMutableDictionary new];
    for(NSDictionary *item in spec) {
        if (!item[@"code"]) continue;
        if (exist[item[@"code"]]) continue;
        if ([[item[@"elementCode"] substringToIndex:3] isNotEqualTo:prefix]) continue;
        NSDictionary *s = [item mutableCopy];
        [s setValue:@[s[@"cclass"],s[@"cmeaning"]] forKey:@"dim"];
        [exist setValue:@YES forKey:s[@"code"]];
        [arr addObject:s];
    }
    return arr;
}

- (NSArray*)getBorderSpec{
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *exist = [NSMutableDictionary new];
    for(NSDictionary *item in spec) {
        if (!item[@"code"]) continue;
        if (exist[item[@"code"]]) continue;
        if ([[item[@"elementCode"] substringToIndex:3] isNotEqualTo:@"J_X"]) continue;
        NSMutableDictionary *s = [item mutableCopy];
        s[@"ios"] = [NSString stringWithFormat:@"%@", s[@"ios"]];
        if (![s[@"ios"] containsString:@","])
            continue;
//        if (s[@"ios"] && ![s[@"ios"] containsString:@","]) {
//            s[@"ios"] = [NSString stringWithFormat:@"%@,%@,%@,%@", s[@"ios"],s[@"ios"],s[@"ios"],s[@"ios"]];
//        }
//        s[@"android"] = [NSString stringWithFormat:@"%@", s[@"android"]];
//        if (s[@"android"] && ![s[@"android"] containsString:@","]) {
//            s[@"android"] = [NSString stringWithFormat:@"%@,%@,%@,%@", s[@"android"],s[@"android"],s[@"android"],s[@"android"]];
//        }
//        s[@"h5"] = [NSString stringWithFormat:@"%@", s[@"h5"]];
//        if ([s[@"h5"] isEqual:@""]) {
//            s[@"h5"] = s[@"ios"];
//        } else if (s[@"h5"] && ![s[@"h5"] containsString:@","]) {
//            s[@"h5"] = [NSString stringWithFormat:@"%@,%@,%@,%@", s[@"h5"],s[@"h5"],s[@"h5"],s[@"h5"]];
//        }
        [s setValue:@[s[@"cclass"],s[@"cmeaning"]] forKey:@"dim"];
        [exist setValue:@YES forKey:s[@"code"]];
        [arr addObject:s];
    }
    return arr;
}

- (NSArray*)getPorderSpec{
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *exist = [NSMutableDictionary new];
    for(NSDictionary *item in spec) {
        if (!item[@"code"]) continue;
        if (exist[item[@"code"]]) continue;
        if ([[item[@"elementCode"] substringToIndex:3] isNotEqualTo:@"J_X"]) continue;
        NSMutableDictionary *s = [item mutableCopy];
        s[@"ios"] = [NSString stringWithFormat:@"%@", s[@"ios"]];
        if ([s[@"ios"] containsString:@","])
            continue;
        s[@"android"] = [NSString stringWithFormat:@"%@", s[@"android"]];
        s[@"h5"] = [NSString stringWithFormat:@"%@", s[@"h5"]];
        [s setValue:@[s[@"cclass"],s[@"cmeaning"]] forKey:@"dim"];
        [exist setValue:@YES forKey:s[@"code"]];
        [arr addObject:s];
    }
    return arr;
}

- (NSArray*)getLineSpec {
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *exist = [NSMutableDictionary new];
    for(NSDictionary *item in spec) {
        if (!item[@"code"]) continue;
        if (exist[item[@"code"]]) continue;
        if ([[item[@"elementCode"] substringToIndex:3] isNotEqualTo:@"L_X"]) continue;
        NSDictionary *s = [item mutableCopy];
        [s setValue:@[s[@"cclass"],s[@"cmeaning"]] forKey:@"dim"];
        [exist setValue:@YES forKey:s[@"code"]];
        [arr addObject:s];
    }
    return arr;
}

- (NSArray*)getMarginSpecWith:(NSString*) prefix {
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableDictionary *exist = [NSMutableDictionary new];
    for(NSDictionary *item in spec) {
        if (!item[@"code"]) continue;
        if (exist[item[@"code"]]) continue;
        if ([[item[@"elementCode"] substringToIndex:5] isNotEqualTo:prefix]) continue;
        NSDictionary *s = [item mutableCopy];
        [s setValue:@[s[@"cclass"],s[@"cmeaning"]] forKey:@"dim"];
        [s setValue: [NSString stringWithFormat:@"%@", s[@"ios"]] forKey:@"desc"];
        [exist setValue:@YES forKey:s[@"code"]];
        [arr addObject:s];
    }
    return arr;
}


- (NSDictionary*)getSpec {
    return @{
        @"Color": [self getColorSpec],
        @"Font": [self getSpecWith:@"T_X"],
        @"Weight": [self getSpecWith:@"F_X"],
        @"Line": [self getLineSpec],
        @"Border":[self getBorderSpec],
        @"Porder":[self getPorderSpec],
        @"Hori":[self getMarginSpecWith:@"M_W_X"],
        @"Vert":[self getMarginSpecWith:@"M_H_X"]
    };
}

@end


