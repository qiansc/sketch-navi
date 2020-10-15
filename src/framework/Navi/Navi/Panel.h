//
//  PanelController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Menu.h"
#import "NVPanelController.h"


// MenuControl 暴露的代理接口
@protocol PanelControlProtocol <NSObject>

@optional
-(void)viewWillLayoutSize:(NSString*)newSize;
@end


NS_ASSUME_NONNULL_BEGIN

@interface Panel : NSViewController

@property (nonatomic,weak) id<PanelControlProtocol> delegate;
@property (nonatomic) int limitWidth;

@property (nonatomic,weak) NSString* documentId;
@property (weak) IBOutlet NSStackView *stackView;
@property (nonatomic,weak) NSMutableDictionary* panelControllers;

+ (instancetype)generateWithDocumentId:(NSString*) documentId;

@end

NS_ASSUME_NONNULL_END
