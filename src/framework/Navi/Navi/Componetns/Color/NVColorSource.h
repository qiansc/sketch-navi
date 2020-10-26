//
//  ColorSpec.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVColorSpec {
    NSString *hex;              // FFFFFF
    NSString *hex1;
    NSString *hex2;
    float alpha;               // 50.00
    NSString *specCode;         // SAM_001
    NSString *desc;             // 语义化
//    NSArray<NSString*>* dim;    // [@"背景色"]
//    BOOL fillMode;
//    BOOL borderMode;
};

typedef struct NVColorSpec NVColorSpec;

@interface NVColorSource : NSObject<NVSource>

-(NSArray<NSString*>*)getDims;

-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
-(NSArray<NSDictionary*>*)getSpecsIn:(long) section;
-(NVColorSpec)getSpecAt:(NSIndexPath *) indexPath;

+(NVColorSpec)value:(NSDictionary*) specDict;

- (void)setMode:(NSInteger) mode;
- (void)setShapeMode:(NSString *) mode;
- (void)setThemeMode:(NSString *) mode;

@end

NS_ASSUME_NONNULL_END
