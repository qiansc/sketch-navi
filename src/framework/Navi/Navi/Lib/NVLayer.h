//
//  NVLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVLayer : NSObject


+(BOOL)isArtboardGroup:(MSLayer*)layer; // 画板

+(BOOL)isTextLayer:(MSLayer*)layer; // 文本

+(BOOL)isShapePathLayer:(MSLayer*)layer; // 矢量 线条

+(BOOL)isBitmapLayer:(MSLayer*)layer; // 图片

+(BOOL)isSliceLayer:(MSLayer*)layer; // 切片

+(BOOL)isHotspotLayer:(MSLayer*)layer; // 热区

+(BOOL)isSymbolInstance:(MSLayer*)layer; // 控件

+(BOOL)isShapeGroup:(MSLayer*)layer; // Shape群组（布尔运算）

+(BOOL)isShape:(MSLayer*)layer; // Shape

+(BOOL)isRectangleShape:(MSLayer*)layer; // 矩形

+(BOOL)isOvalShape:(MSLayer*)layer; // 圆形

+(BOOL)isTriangleShape:(MSLayer*)layer; // 三角形

+(BOOL)isStarShape:(MSLayer*)layer; // 星形

+(BOOL)isPolygonShape:(MSLayer*)layer; // 多边形

@end

NS_ASSUME_NONNULL_END
