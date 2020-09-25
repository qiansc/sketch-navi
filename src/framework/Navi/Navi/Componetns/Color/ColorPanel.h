//
//  ColorMiniPanel.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataChangeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColorPanel : NSViewController

@property (strong) IBOutlet NSView *view;
@property (nonatomic,weak) NSString *selectedCode;
@property (nonatomic,weak) id<DataChangeProtocol> delegate;

+ (instancetype)viewControllerFromNIB;


- (void)select:(NSString *) colorCode;
- (void)reset;

@end


NS_ASSUME_NONNULL_END
