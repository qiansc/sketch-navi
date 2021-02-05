//
//  NVPorderSource.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVPorderSpec {
    float alpha;                // 50.00
    NSString *code;             // F_Txt_X4
    NSString *cline;            // FEED
    NSString *cclass;           // 标题基础模板
    NSString *cmeaning;         // 模块弱化标题
    NSString *elementCode;      // Txt_X010
    NSString *ios;              // 3,3,3,3
    NSString *android;          // 5,5,5,5
    NSString *h5;               //
};

typedef struct NVPorderSpec NVPorderSpec;

@interface NVPorderSource : NSObject<NVSource, NSCollectionViewDataSource>

@property (nonatomic) BOOL semanticMode;

-(NSArray<NSString*>*)getDims;
-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
-(NSArray<NSDictionary*>*)getSpecsIn:(long) section;
-(NVPorderSpec)getSpecAt:(NSIndexPath *) indexPath;
+(NVPorderSpec)value:(NSDictionary*) specDict;

- (void)onUpdated:(NVSourceUpdateCallback) callback;

@end

// {"code":"S_J_X15","cline":"搜索","cclass":"元素边角","cmeaning":"圆角","elementCode":"J_X15","ios":"","android":"","h5":"27,27,27,27"}

NS_ASSUME_NONNULL_END
