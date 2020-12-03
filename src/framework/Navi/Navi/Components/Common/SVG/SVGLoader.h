//
//  SVGLoader.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/12/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVGKit/SVGKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVGLoader : NSObject

+ (SVGKImage *)fromRawUTF8SVGString:(NSString *) content;

+ (SVGKImage *)fromURLString:(NSString *) url;

@end

NS_ASSUME_NONNULL_END
