//
//  MSFill.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSColor.h"
#import "MSGradient.h"

@interface MSStyleFill: NSObject

@property (nonatomic, strong) MSColor *color;
@property(retain, nonatomic) MSGradient *gradient;
@property(nonatomic) unsigned long long fillType; // @synthesize fillType=_fillType;

@end
