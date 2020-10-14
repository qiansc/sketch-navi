//
//  LinePanel.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataChangeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinePanel : NSViewController

@property (strong) IBOutlet NSView *view;
@property (nonatomic,weak) NSString *selectedCode;

@property (nonatomic, weak) id<DataChangeProtocol> delegate;

+ (instancetype) viewControllerFromNIB;

- (void)select:(NSString *) lineCode;

@end

NS_ASSUME_NONNULL_END
