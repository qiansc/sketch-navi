//
//  ColorCollection.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DidLayoutHandler)(float num);

@interface ColorCollection : NSViewController

@property (nonatomic, strong) DidLayoutHandler layoutHandler;

@end

NS_ASSUME_NONNULL_END
