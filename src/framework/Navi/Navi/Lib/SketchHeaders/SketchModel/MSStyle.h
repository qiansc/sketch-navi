//
//  MSStyle.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSStyleFill.h"
#import "MSStyleBorder.h"
#import "MSStyleShadow.h"

@interface MSStyle: NSObject

@property (nonatomic, strong) NSArray<MSStyleFill*> *fills;
@property (nonatomic, strong) NSArray<MSStyleBorder*> *borders;
@property (nonatomic, strong) NSArray *shadows;
- (id)addStylePartOfType:(unsigned long)arg1;
- (void)addStyleFill:(id)arg1;
- (void)removeAllStyleFills;
- (void)removeStyleFillsAtIndexes:(id)arg1;
- (void)removeStyleFillAtIndex:(unsigned long long)arg1;
- (void)removeStyleFill:(id)arg1;
@end
