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

@interface Menu : NSViewController {
    int limitWidth;
    NSMutableDictionary* panelButtons;
}
    
@property (nonatomic,strong) id<MenuControlProtocol> delegate;
@property (strong) IBOutlet NSStackView *headStack;
@property (nonatomic, strong) NSButton *mainButton;

@property (nonatomic, strong) NSString* documentId;

// Convenience Method
+ (instancetype)generateWithDocumentId:(NSString*) documentId;
- (void)viewWillTransitionToSize:(NSSize)newSize;
- (void)updateLimitWidth;

@end
NS_ASSUME_NONNULL_END
