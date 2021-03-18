//
//  NVBundle.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/2.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVBundle.h"

@implementation NVBundle

+(NSBundle *)bundlePath {
    NSString* const frameworkBundleID  = @"com.baidu.navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return resourceBundlePath;
}
+(NSBundle *)SketchModelBundle {
    return [NSBundle bundleWithIdentifier:@"com.bohemiancoding.SketchModel"];
}

+(NSBundle *)SketchControllersBundle {
    return [NSBundle bundleWithIdentifier:@"com.bohemiancoding.SketchControllers"];
}

+(NSBundle *)SketchRenderingBundle {
    return [NSBundle bundleWithIdentifier:@"com.bohemiancoding.SketchRendering"];
}

@end


//NSString *nibPath = [[[NSBundle bundleForClass:[self class]] bundlePath]
//       stringByAppendingString:@"/Contents/Resources/.nib"];
