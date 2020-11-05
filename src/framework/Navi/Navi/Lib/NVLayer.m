//
//  NVLayer.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLayer.h"


@implementation NVLayer

+(BOOL)isArtboardGroup:(MSLayer*)layer // 画板
    {return [[layer className] isEqual:@"MSArtboardGroup"];}

+(BOOL)isTextLayer:(MSLayer*)layer // 文本
    {return [[layer className] isEqual:@"MSTextLayer"];}

+(BOOL)isShapePathLayer:(MSLayer*)layer // 矢量 线条
    {return [[layer className] isEqual:@"MSShapePathLayer"];}

+(BOOL)isBitmapLayer:(MSLayer*)layer // 图片
    {return [[layer className] isEqual:@"MSBitmapLayer"];}

+(BOOL)isSliceLayer:(MSLayer*)layer // 切片
    {return [[layer className] isEqual:@"MSSliceLayer"];}

+(BOOL)isHotspotLayer:(MSLayer*)layer // 热区
    {return [[layer className] isEqual:@"MSHotspotLayer"];}

+(BOOL)isSymbolInstance:(MSLayer*)layer // 控件
    {return [[layer className] isEqual:@"MSSymbolInstance"];}

+(BOOL)isShapeGroup:(MSLayer*)layer // Shape群组（布尔运算）
    {return [[layer className] isEqual:@"MSShapeGroup"];}

+(BOOL)isShape:(MSLayer*)layer; // Shape
    {return [NVLayer isShapeGroup:layer] || [[layer className] hasSuffix:@"Shape"];}

+(BOOL)isRectangleShape:(MSLayer*)layer // 矩形
    {return [[layer className] isEqual:@"MSRectangleShape"];}

+(BOOL)isOvalShape:(MSLayer*)layer // 圆形
    {return [[layer className] isEqual:@"MSOvalShape"];}

+(BOOL)isTriangleShape:(MSLayer*)layer // 三角形
    {return [[layer className] isEqual:@"MSTriangleShape"];}

+(BOOL)isStarShape:(MSLayer*)layer // 星形
    {return [[layer className] isEqual:@"MSStarShape"];}

+(BOOL)isPolygonShape:(MSLayer*)layer // 多边形
    {return [[layer className] isEqual:@"MSPolygonShape"];}

@end
