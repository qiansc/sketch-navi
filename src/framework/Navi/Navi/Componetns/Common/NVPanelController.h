//
//  NVPanelController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PanelHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVPanelController : NSViewController

@property (strong) IBOutlet PanelHeaderView *headerView;
@property (strong) NSString *panelId;

@property (nonatomic) NSControlStateValue openState;
@property (nonatomic) NSLayoutConstraint* constraintHeight;

- (instancetype) initWithId:(NSString*) id;
- (void)setOpenStateSlient:(NSControlStateValue)state;
@end

NS_ASSUME_NONNULL_END
