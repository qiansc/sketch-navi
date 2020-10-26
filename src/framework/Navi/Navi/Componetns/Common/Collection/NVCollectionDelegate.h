//
//  NVCollectionDelegate.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVToggleBox.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnChangeCallback)(NVToggleBox* box);
typedef void (^AfterReloadCallback)(void);

@interface NVCollectionDelegate : NSObject

@property (nonatomic, strong) NSCollectionView *collectionView;

/* setActive并不是排他性的 有值回调 */
-(void)setActive:(NSIndexPath *)indexPath;
/* setActives是排他性的 没有回调 */
-(void)setActives:(NSArray<NSIndexPath*>*) indexPaths;
/* 有回调 */
-(void)onChange:(OnChangeCallback) onChangeCallback;
-(void)clearActive;


- (void)afterReload:(AfterReloadCallback) afterReloadCallback;
- (void)triggerAfterReload;

@end


NS_ASSUME_NONNULL_END
