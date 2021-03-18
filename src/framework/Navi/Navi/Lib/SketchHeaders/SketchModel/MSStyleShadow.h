//
//  MSStyleShadow.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/8.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import "MSColor.h"

@interface MSStyleShadow: NSObject

@property (nonatomic, strong) MSColor *color;
@property (nonatomic) double offsetX;
@property (nonatomic) double offsetY;
@property (nonatomic) double blurRadius;
@property (nonatomic) double spread;

@end
