//
//  NVDocument.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

// MenuControl 暴露的代理接口
@protocol NVDocumentLayoutProtocol <NSObject>
@required
-(void)viewWillLayout;
@end


@interface NVDocument : NSViewController

@property (nonatomic, strong) NSObject<NVDocumentLayoutProtocol> *delegate;

@end

NS_ASSUME_NONNULL_END
