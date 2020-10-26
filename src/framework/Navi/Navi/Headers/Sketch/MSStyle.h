//
//  MSStyle.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSStyleFill.h"
#import "MSStyleBorder.h"

@interface MSStyle: NSObject

@property (nonatomic, strong) NSArray<MSStyleFill*> *fills;
@property (nonatomic, strong) NSArray<MSStyleBorder*> *borders;

@end

