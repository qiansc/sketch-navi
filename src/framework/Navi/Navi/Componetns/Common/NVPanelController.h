//
//  NVPanelController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVPanelHeaderView.h"
#import "NVSource.h"
#import "MSLayer.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NVPanelProtocol <NSObject>

@required
- (void)panel:(NSString*) panelId changeState:(NSControlStateValue) state;

@optional
- (void)panelDidResize:(NSString*) panelId;

@end

@interface NVPanelController : NSViewController {
    NSControlStateValue openState;
    NSLayoutConstraint* constraintHeight;

}

@property (strong) IBOutlet NVPanelHeaderView *headerView;
@property (strong) NSString *panelId;
@property (nonatomic, strong) id<NVPanelProtocol> panelDelegate;

- (instancetype) initWithId:(NSString*) id;
- (void)setOpenStateSlient:(NSControlStateValue)state;
- (NSObject<NVSource>*)generatePanelSource;
- (int)height; // 插件展开高度算法，需要自行子类实现
- (void)resetConstraint;
- (void)selectionChange:(NSArray<MSLayer*>*) layers;

@end

NS_ASSUME_NONNULL_END
