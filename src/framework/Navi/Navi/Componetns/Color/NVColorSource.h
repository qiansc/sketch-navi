//
//  ColorSpec.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

struct NVColorSpec {
    NSString *hex;              // FFFFFF
    float alpha;               // 50.00
    NSString *specCode;         // SAM_001
    NSString *desc;             // 语义化
//    NSArray<NSString*>* dim;    // [@"背景色"]
    BOOL fillMode;
    BOOL borderMode;
};
typedef struct NVColorSpec NVColorSpec;

@interface NVColorSource : NSObject

-(NSArray<NSString*>*)getDims;

-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
-(NSArray<NSDictionary*>*)getSpecsIn:(int) section;
-(NVColorSpec)getSpecAt:(NSIndexPath *) indexPath;

+(NVColorSpec)value:(NSDictionary*) specDict;

@end

NS_ASSUME_NONNULL_END
