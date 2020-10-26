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

@interface Panel : NSViewController<NVPanelProtocol>

@property (nonatomic, strong) NSString* documentId;
@property (nonatomic, strong) id<PanelControlProtocol> delegate;
@property (strong) IBOutlet NSStackView *stackView;
@property (nonatomic, strong) IBOutlet NSScrollView* scrollView;
@property (strong) IBOutlet NSTextField *searchField;
@property (strong) IBOutlet NSButton *semanticButton;

+ (instancetype)generateWithDocumentId:(NSString*) documentId;
- (void)updateSpec:(NSDictionary *) object;
- (void)selectionChange;


@end

NS_ASSUME_NONNULL_END
