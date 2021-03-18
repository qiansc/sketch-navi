//
//  Util.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Util.h"
#import "HexColor.h"
#import "MSDocument.h"
#import "NVBundle.h"

@implementation Util


+ (NSImage*)createImage:(NSURL*) imageURL withSize:(NSSize) size {
    NSImage* image = [[NSImage alloc]initWithContentsOfURL:imageURL];
    [image setSize:size];
    [image setScalesWhenResized:YES];
    return image;
}

+ (NSBox*)separtorBox {
    NSBox *separtorBox = [[NSBox alloc]initWithFrame:NSZeroRect];
    [separtorBox setBoxType:NSBoxSeparator];
    [separtorBox setBorderColor:NSColorFromRGBString(@"#F5F5F5")];
    return separtorBox;
}

+ (void)fillSuperview:(NSView*)view{
    NSView *superview = view.superview;
    view.frame = NSMakeRect(0, 0, superview.frame.size.width, superview.frame.size.height);
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

+ (void)position:(MSLayer*)layer at:(CGPoint) point {
    CGPoint parentOffset = [Util parentOffsetInArtboard:layer];
    layer.frame.x = point.x - parentOffset.x;
    layer.frame.y = point.y - parentOffset.y;
}

+ (CGPoint)parentOffsetInArtboard:(MSLayer*)layer {
    CGPoint offset = {.x=0,.y=0};
    MSLayer *parent = layer.parentObject;
    
    while (parent && parent.parentObject) {
        offset.x += parent.frame.x;
        offset.y += parent.frame.y;
        parent = parent.parentObject;
        if ([parent.className containsString:@"MSArtboard"]) {
            parent = nil;
        }
    }
    
    return offset;
}

+ (void)message:(NSString *) string{
    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:string];
}

+ (NSURL*)applicationDataDirectory {
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSApplicationSupportDirectory
                                 inDomains:NSUserDomainMask];
    NSURL* appSupportDir = nil;
    NSURL* appDirectory = nil;

    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        appSupportDir = [possibleURLs objectAtIndex:0];
    }

    // If a valid app support directory exists, add the
    // app's bundle ID to it to specify the final directory.
    if (appSupportDir) {
        NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    appDirectory = [appDirectory URLByAppendingPathComponent:@"Plugins/cache/"];
    
    if (![sharedFM fileExistsAtPath: [appDirectory absoluteString] isDirectory:YES]) {
        BOOL ret = [sharedFM createDirectoryAtURL:appDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        if (ret)
            return appDirectory;
        else
            return nil;
    }

    return appDirectory;
}


+ (NSURL*)resourceURL:(NSString*) prefix {
    NSURL *bundleURL = [NVBundle bundlePath].bundleURL;
    bundleURL = [[bundleURL URLByDeletingLastPathComponent]URLByDeletingLastPathComponent];
    if (prefix) {
        
    }
    NSURL *url = [bundleURL URLByAppendingPathComponent:prefix isDirectory:NO];
    return url;
}

+ (NSDictionary*)loadConfig {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *url = [Util resourceURL:@"data/config"];
    if (![fm fileExistsAtPath: url.path]) {
        NSLog(@"### Use Default Config");
        return [Util appConfig];
    }
    NSData *json = [NSData dataWithContentsOfURL:url];
    json = [json initWithBase64EncodedData:json options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSError *err;
    NSDictionary *conf = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&err];
    if (conf[@"host"] && conf[@"loginAPI"] && conf[@"codeAPI"]) {
        return conf;
    }
    return nil;
}

+ (NSDictionary*)appConfig {
    return @{
        @"host": @"http://wuji.baidu-int.com",
        @"loginAPI": @"/openapi/uikit/client?action=verifyMailCode&mailcode=%@",
        @"codeAPI": @"/openapi/uikit/client?action=requestMailCode&mail=%@",
        @"specColorAPI": @"/openapi/uikit/getDepartmentData?source=%@&cversion=%@&type=%@",
        @"specAPI": @"/openapi/uikit/getBusinessData?source=%@&cversion=%@",
        @"sourceList": @[
                @{
                    @"id": @"baiduboxapp", @"label": @"百度APP",
                    @"specVersions": @[@"11.26", @"12.0", @"12.1.5"],
                    @"groupList": @[
                            @{@"id": @"GC", @"label": @"全局"},
                            @{@"id": @"SC", @"label": @"搜索"},
                            @{@"id": @"DC", @"label": @"搜索H5"},
                            @{@"id": @"IC", @"label": @"互动"},
                            @{@"id": @"FC", @"label": @"FEED"},
                            @{@"id": @"VC", @"label": @"视频"},
                            @{@"id": @"LC", @"label": @"直播"},
                            @{@"id": @"ALC", @"label": @"直播1"},
                            @{@"id": @"BC", @"label": @"基础"},
                            @{@"id": @"UC", @"label": @"基础组件"},
                            @{@"id": @"NC", @"label": @"小说"},
                            @{@"id": @"CC", @"label": @"动漫"}
                    ]
                },@{
                    @"id": @"tiebaapp", @"label": @"贴吧APP",
                    @"specVersions": @[@"默认"],
                    @"groupList": @[@{@"id": @"CAM", @"label": @"贴吧"}]
                },@{
                    @"id": @"pc", @"label": @"PC搜索",
                    @"specVersions": @[@"默认"],
                    @"groupList": @[@{@"id": @"CAM", @"label": @"pc"}]
                },@{
                    @"id": @"netdiskapp", @"label": @"网盘APP",
                    @"specVersions": @[@"默认"],
                    @"groupList": @[@{@"id": @"CAM", @"label": @"网盘"}]
                }
        ]
    };
//    return @{
//        @"host": @"https://raw.githubusercontent.com",
//        @"loginAPI": @"/design-to-release/sketch-navi/master/demo/api/verify-success.json?code=%@",
//        @"codeAPI": @"/design-to-release/sketch-navi/master/demo/api/request-code.json?mail=%@"
//    };
}

+ (void)generateConfig{
    NSURL *url = [Util resourceURL:@"data/config"];
    NSData *json = [NSJSONSerialization dataWithJSONObject:[Util appConfig] options:NSJSONWritingPrettyPrinted error:nil];
    json = [json base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    BOOL ret = [json writeToURL:url atomically:YES];
    if (ret)
        NSLog(@"### generate config at %@", url);
    else
        NSLog(@"### generate fail at %@", url);
}

+ (int)sketchVersion {
    return [[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] intValue];
}
@end
