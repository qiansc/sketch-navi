//
//  NVShadowSource.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVShadowSpec {
    NSString *code;
    NSString *cline;
    NSString *cclass;
    NSString *cmeaning;
    NSString *elementCode;
    NSString *color;
    double x;
    double y;
    double size;
    double opacity;
};

typedef struct NVShadowSpec NVShadowSpec;

@interface NVShadowSource : NSObject<NVSource, NSCollectionViewDataSource>

@property (nonatomic) BOOL semanticMode;
- (NSArray<NSString *> *)getDims;
- (NSArray<NSDictionary *> *)getSpecsWith:(NSString *) dim;
- (NSArray<NSDictionary*>*)getSpecsIn:(long) section;
- (NVShadowSpec)getSpecAt:(NSIndexPath *) indexPath;
+ (NVShadowSpec)value:(NSDictionary*) specDict;

@end

NS_ASSUME_NONNULL_END
