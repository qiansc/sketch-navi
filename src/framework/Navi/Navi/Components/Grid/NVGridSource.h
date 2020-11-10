//
//  NVGridSource.h
//  Navi
//
//  Created by QIANSC on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVGridSpec {
    float alpha;                // 50.00
    NSString *code;             // F_Txt_X4
    NSString *cline;            // FEED
    NSString *cclass;           // 标题基础模板
    NSString *cmeaning;         // 模块弱化标题
    NSString *desc;         // 模块弱化标题
    NSString *elementCode;      // Txt_X010
    NSString *scale;
    double ios;              // 3,3,3,3
    double android;          // 5,5,5,5
    double h5;               //
};

typedef struct NVGridSpec NVGridSpec;

@interface NVGridSource : NSObject<NVSource, NSCollectionViewDataSource>

@property (nonatomic) BOOL semanticMode;

-(NSArray<NSString*>*)getDims;
-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
-(NSArray<NSDictionary*>*)getSpecsIn:(long) section;
-(NVGridSpec)getSpecAt:(NSIndexPath *) indexPath;
+(NVGridSpec)value:(NSDictionary*) specDict;


@end

// {"code":"S_J_X15","cline":"搜索","cclass":"元素边角","cmeaning":"圆角","elementCode":"J_X15","ios":"","android":"","h5":"27,27,27,27"}

NS_ASSUME_NONNULL_END
