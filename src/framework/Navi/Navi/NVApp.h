//
//  NVApp.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "MSSplitView.h"
#import "NVDocument.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NVDataSource <NSObject>
//@required
-(void)updateSpec;
-(NSDictionary*)getSpec;
@end


@interface NVApp : NSObject<NVDocumentLayoutProtocol>

@property (nonatomic, strong) NSString *bundlePath;
@property (nonatomic, strong) NSObject<NVDataSource> *dataSource;
@property (nonatomic, strong) NSDictionary *specs;
@property (nonatomic, strong) MSSplitView *splitView;

+(instancetype)prepareInit;
+(instancetype)currentApp;
- (void)viewWillLayout;
-(void)toggle;


@end

NS_ASSUME_NONNULL_END
