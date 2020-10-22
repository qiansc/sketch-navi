//
//  NVCollectionDelegate.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVCollectionView.h"
#import "NVToggleBox.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnChangeCallback)(NVToggleBox* box);

@interface NVCollectionDelegate : NSObject

@property (nonatomic, strong) NVCollectionView *collectionView;

-(void)setActive:(NSIndexPath *)indexPath;
-(void)onChange:(OnChangeCallback) onChangeCallback;
-(void)clearActive;
@end


NS_ASSUME_NONNULL_END