//
//  PanelController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/18.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Menu.h"
#import "NVPanel.h"


//@protocol PanelControlProtocol <NSObject>
//
//@optional
//    -(void)viewWillLayoutSize:(NSString*)newSize;
//@end


NS_ASSUME_NONNULL_BEGIN

@interface Panel : NSViewController<NVPanelProtocol>

@property (nonatomic, strong) NSString* documentId;
@property (strong) IBOutlet NSStackView *stackView;
@property (nonatomic, strong) IBOutlet NSScrollView* scrollView;
@property (strong) IBOutlet NSTextField *searchField;
@property (strong) IBOutlet NSButton *semanticButton;
@property (strong) IBOutlet NSButton *floatButton;

+ (instancetype)generateWithDocumentId:(NSString*) documentId;
- (void)updateSpec:(NSDictionary *) object;
- (void)selectionChange;
- (void)onPaste;
- (void)beforeCopy;
- (void)scrollToPanel:(NSString *)panelId;


@end

NS_ASSUME_NONNULL_END
