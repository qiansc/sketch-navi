//
//  NVMaskSource.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "NVSource.h"

NS_ASSUME_NONNULL_BEGIN

struct NVMaskSpec {
    NSString *code; // F_Mask_X2
    NSString *cline; // "FEED"
    NSString *cclass; // "图片"
    NSString *cmeaning; // "卡片+容器（图片上有文字内容的）"
    NSString *color; // "000000"
    NSString *elementCode; // Mask_X11
    NSString *direction; // bottom
    double startOpacity; // 0
    double endOpacity; // 0
};

typedef struct NVMaskSpec NVMaskSpec;

@interface NVMaskSource : NSObject<NVSource, NSCollectionViewDataSource>

@property (nonatomic) BOOL semanticMode;

- (NSArray<NSString *> *)getDims;
- (NSArray<NSDictionary *> *)getSpecsWith:(NSString *) dim;
- (NSArray<NSDictionary *> *)getSpecsIn:(long) section;
- (NVMaskSpec)getSpecAt:(NSIndexPath *) indexPath;
+ (NVMaskSpec)value:(NSDictionary *) specDict;

@end

NS_ASSUME_NONNULL_END
