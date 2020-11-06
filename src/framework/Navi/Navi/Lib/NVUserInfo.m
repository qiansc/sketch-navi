//
//  NVUserInfo.m
//  Navi
//
//  Created by QIANSC on 2020/11/4.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVUserInfo.h"
#import "MSStyleFill.h"

@implementation NVUserInfo {
    MSLayer *_layer;
}

static NSMutableDictionary *cache;

+(instancetype)fromLayer:(MSLayer*) layer {
    if (cache == nil) cache = [NSMutableDictionary new];
    if (cache[layer.objectID]) {
        return cache[layer.objectID];
    }
    NVUserInfo * userInfo = [[NVUserInfo alloc] initWithLayer:layer];
    cache[layer.objectID] = userInfo;
    return userInfo;
}

-(void)save{
    NSMutableDictionary *origin;
    if (_layer.userInfo == nil) {
        origin = [NSMutableDictionary new];
    } else {
        origin = [_layer.userInfo mutableCopy];
    }
    [origin setObject:self.data forKey:@"sketch-navi"];
    _layer.userInfo = origin;
}

-(instancetype)initWithLayer:(MSLayer*) layer {
    // [super init];
    _layer = layer;
    if (layer.userInfo == nil || layer.userInfo[@"sketch-navi"] == nil) {
        self.data = [NSMutableDictionary new];
        self.data[@"style"] = [NSMutableDictionary new];
        self.data[@"style"][@"fills"] = [NSMutableArray new];
        self.data[@"style"][@"borders"] = [NSMutableArray new];
        self.data[@"textColorCode"] = @"";
        self.data[@"textCode"] = @"";
    } else {
        self.data = [layer.userInfo[@"sketch-navi"] mutableCopy];
    }
    return self;
}

#pragma mark Text

-(NSString*)textCode { return self.data[@"textCode"]; }

-(void)setTextCode:(NSString*)code {
    self.data[@"textCode"] = code;
    [self save];
}

-(NSString*)fontColorCode { return self.data[@"fontColorCode"]; }

-(void)setFontColorCode:(NSString*)code {
    self.data[@"fontColorCode"] = code;
    [self save];
}

#pragma mark Style-Fill

-(NSString *)fillColorCode { // 默认只返回一个 如果需要多个自行访问data.style.fills 获取 下同
    for(NSDictionary* d in self.data[@"style"][@"fills"]) {
        if (d[@"colorCode"]) return d[@"colorCode"];
    }
    return nil;
}

-(void)setFillColorCode:(NSString*)code {
    if ([self.data[@"style"][@"fills"] count] == 0)
        [self.data[@"style"][@"fills"] addObject:[NSMutableDictionary new]];
    self.data[@"style"][@"fills"][0][@"colorCode"] = code;
    [self save];
}

#pragma mark Style-Border

-(NSString *)borderColorCode {
    for(NSDictionary* d in self.data[@"style"][@"borders"]) {
        if (d[@"colorCode"]) return d[@"colorCode"];
    }
    return nil;
}

-(void)setBorderColorCode:(NSString*)code {
    if ([self.data[@"style"][@"borders"] count] == 0)
        [self.data[@"style"][@"borders"] addObject:[NSMutableDictionary new]];
    self.data[@"style"][@"borders"][0][@"colorCode"] = code;
    [self save];
}


-(NSString *)borderThicknessCode {
    for(NSDictionary* d in self.data[@"style"][@"borders"]) {
        if (d[@"borderThicknessCode"]) return d[@"borderThicknessCode"];
    }
    return nil;
}

-(void)setBorderThicknessCode:(NSString*)code {
    if ([self.data[@"style"][@"borders"] count] == 0)
        [self.data[@"style"][@"borders"] addObject:[NSMutableDictionary new]];
    self.data[@"style"][@"borders"][0][@"borderThicknessCode"] = code;
    [self save];
}


#pragma mark Points - CurvePoint

-(NSString *)cornerRadiusCode {return self.data[@"cornerRadiusCode"];}
-(void)setCornerRadiusCode:(NSString*)code {
    self.data[@"cornerRadiusCode"] = code;
    [self save];
}

#pragma mark Frame

-(NSString *)gridWidthCode {return self.data[@"gridWidthCode"];}
-(void)setGridWidthCode:(NSString*)code {
    self.data[@"gridWidthCode"] = code;
    [self save];
}


-(NSString *)gridScaleCode {return self.data[@"gridScaleCode"];}
-(void)setGridScaleCode:(NSString*)code {
    self.data[@"gridScaleCode"] = code;
    [self save];
}

@end
