//
//  NVBundle.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/2.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVBundle : NSObject

+(NSBundle *)bundlePath;

+(NSBundle *)SketchModelBundle;

+(NSBundle *)SketchControllersBundle;

+(NSBundle *)SketchRenderingBundle;

@end

NS_ASSUME_NONNULL_END
