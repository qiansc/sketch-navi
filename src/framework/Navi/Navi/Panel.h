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

@interface Panel : NSViewController<PanelStateChangeProtocol> {
    int limitWidth;
    NSMutableDictionary* panelControllers;
}

@property (nonatomic, strong) NSString* documentId;
@property (nonatomic, strong) id<PanelControlProtocol> delegate;
@property (weak) IBOutlet NSStackView *stackView;

+ (instancetype)generateWithDocumentId:(NSString*) documentId;

@end

NS_ASSUME_NONNULL_END
