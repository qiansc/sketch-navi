//
//  SVGLoader.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/12/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "SVGLoader.h"

@implementation SVGLoader

+ (SVGKImage *)fromRawUTF8SVGString:(NSString *) content {
    NSData *data = [content dataUsingEncoding: NSUTF8StringEncoding];
    NSInputStream *inputStream = [[NSInputStream alloc] initWithData:data];
    SVGKSource *source = [[SVGKSource alloc] initWithInputSteam: inputStream];
    return [SVGKImage imageWithSource:source];
}

+ (SVGKImage *)fromURLString:(NSString *) urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    return [SVGKImage imageWithContentsOfURL:url];
}

@end
