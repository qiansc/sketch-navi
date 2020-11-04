//
//  MSLayer.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSStyle.h"

@interface MSLayer: NSObject

@property (readonly, nonatomic) NSString *objectID;
@property (nonatomic, strong) NSString *type; // ShapePath / Text
@property (nonatomic, strong) MSStyle *style;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) MSColor *textColor;
@property (nonatomic) double fontSize;
@property (nonatomic, strong) NSFont *font;
@end
