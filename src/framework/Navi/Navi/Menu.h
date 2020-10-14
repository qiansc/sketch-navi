//
//  MenuController.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Util.h"

NS_ASSUME_NONNULL_BEGIN

// MenuControl 暴露的代理接口
@protocol MenuControlProtocol <NSObject>

@optional
-(void)onButtonClick:(NSDictionary*)option;
-(void)viewWillLayoutSize:(NSDictionary*)option;
@end

@interface Menu : NSViewController
    
@property (nonatomic,weak) id<MenuControlProtocol> delegate;
@property (strong) IBOutlet NSView *view;
@property (strong) IBOutlet NSStackView *headStack;
@property (nonatomic, weak) NSButton *mainButton;
@property (nonatomic) int limitWidth;


// Convenience Method
+ (instancetype)generateWithDocumentId:(NSString*) documentId;
- (void)viewWillTransitionToSize:(NSSize)newSize;
- (void)updateLimitWidth;

@end
NS_ASSUME_NONNULL_END
