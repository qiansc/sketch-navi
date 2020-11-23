//
//  NVWeightSource.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVWeightSpec {
    float alpha;                // 50.00
    NSString *code;             // F_Txt_X4
    NSString *cline;            // FEED
    NSString *cclass;           // 标题基础模板
    NSString *cmeaning;         // 模块弱化标题
    NSString *elementCode;      //Txt_X010
    double iosFont;             // 400,
    double androidFont;         // 400,
    double h5Font;              // 400,
    double iosFontSize;         // 17,
    double androidFontSize;     // 15,
    double h5FontSize;          // 51,
    NSString *camId;            //'CAM_X350',
    NSString *defaultColor;
    NSString *darkColor;
    NSString *nightColor;

//    defaultValue: { color: '000000', opacity: 1, rgba: '0, 0, 0, 1' },
//    darkValue: { color: 'FFFFFF', opacity: 1, rgba: '255, 255, 255, 1' },
//    nightValue: { color: '666666', opacity: 1, rgba: '102, 102, 102, 1' },
//    dim: [ '标题基础模板', '模块弱化标题' ] } ]

};

typedef struct NVWeightSpec NVWeightSpec;

@interface NVWeightSource : NSObject<NVSource, NSCollectionViewDataSource>

@property (nonatomic) BOOL semanticMode;

-(NSArray<NSString*>*)getDims;

-(NSArray<NSDictionary*>*)getSpecsWith:(NSString *)dim;
-(NSArray<NSDictionary*>*)getSpecsIn:(long) section;
-(NVWeightSpec)getSpecAt:(NSIndexPath *) indexPath;

+(NVWeightSpec)value:(NSDictionary*) specDict;

- (void)setShapeMode:(NSString *) mode;
- (void)setThemeMode:(NSString *) mode;

- (void)onUpdated:(NVSourceUpdateCallback) callback;

@end

NS_ASSUME_NONNULL_END
