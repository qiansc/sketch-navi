//
//  LineCellView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface LineCellView : NSButton

@property (nonatomic, assign) NSNumber* lineSize;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) NSTrackingArea *trackingArea;
@property (nonatomic, assign) BOOL hover;

-(void) updateState;

@end

NS_ASSUME_NONNULL_END
