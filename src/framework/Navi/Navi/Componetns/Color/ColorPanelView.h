//
//  ColorPanelView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ColorPanel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColorPanelView : NSView

@property (strong) IBOutlet NSView *view;

@property (nonatomic,weak) ColorPanel *colorPanelController;

@end

NS_ASSUME_NONNULL_END
