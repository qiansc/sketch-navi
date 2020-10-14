//
//  LinePanelView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LinePanel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinePanelView : NSView

@property (strong) IBOutlet NSView *view;
@property (nonatomic,strong) LinePanel *linePanelController;

@end

NS_ASSUME_NONNULL_END
