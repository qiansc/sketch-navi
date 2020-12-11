//
//  NVDocument.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVMenuView.h"
#import "NVPanelView.h"

NS_ASSUME_NONNULL_BEGIN

// MenuControl 暴露的代理接口
@protocol NVDocumentLayoutProtocol <NSObject>
@required
-(void)viewWillLayout;
-(void)viewLimitBetweenMinimum:(float)minWidth andMaximum:(float)maxWidth;
@end


@interface NVDocument : NSViewController<MenuProtocol, NSWindowDelegate>

@property (nonatomic, strong) NSObject<NVDocumentLayoutProtocol> *delegate;

@property (nonatomic, strong) IBOutlet NVMenuView *menuView;
@property (nonatomic, strong) IBOutlet NVPanelView *panelView;
@property (readonly) float minWidth;
@property (readonly) float maxWidth;


@end

NS_ASSUME_NONNULL_END
