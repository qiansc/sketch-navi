//
//  NVBorderSource.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVBorderSpec {
    float alpha;                // 50.00
    NSString *code;             // F_Txt_X4
    NSString *cline;            // FEED
    NSString *cclass;           // 标题基础模板
    NSString *cmeaning;         // 模块弱化标题
    NSString *elementCode;      //Txt_X010
};

typedef struct NVBorderSpec NVBorderSpec;

@interface NVBorderSource : NSObject<NVSource, NSCollectionViewDataSource>

@property (nonatomic) BOOL semanticMode;

-(NSArray<NSString*>*)getDims;
-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
-(NSArray<NSDictionary*>*)getSpecsIn:(long) section;
-(NVBorderSpec)getSpecAt:(NSIndexPath *) indexPath;
+(NVBorderSpec)value:(NSDictionary*) specDict;


@end

NS_ASSUME_NONNULL_END
