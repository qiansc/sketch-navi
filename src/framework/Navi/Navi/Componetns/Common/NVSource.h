//
//  NVPanelSource.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NVSourceUpdateCallback)(void);

@protocol NVSourceChangeDelegate <NSObject>
@required
-(void)onSourceUpdated;
@end

@protocol NVSource <NSObject>

@required
/* 数据更新方法 */
- (void)update:(NSObject*) specs;

@required
/* 检索词设置方法 */
- (void)setQuery:(NSString *) query;

/* 检索词设置方法 */
- (void)setSemanticMode:(BOOL) mode;

@end

NS_ASSUME_NONNULL_END
