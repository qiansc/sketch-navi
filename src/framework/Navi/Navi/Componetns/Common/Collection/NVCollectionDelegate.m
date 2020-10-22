//
//  NVCollectionDelegate.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCollectionDelegate.h"

@implementation NVCollectionDelegate {
    NSMutableArray<OnChangeCallback>* onChangeCallbacks;
}

/* setActive并不是排他性的 有值回调 */
-(void)setActive:(NSIndexPath *)indexPath {
    NVToggleBox *selectedItem = nil;
    for(NSView *view in self.collectionView.subviews){
        if([view isKindOfClass:[NVToggleBox class]]) {
            NVToggleBox *item = view;
            if ([indexPath isEqual: item.indexPath]) {
                if (!item.isSelected) {
                    [item setSelected];
                }
                selectedItem = item;
            }
//            else {
//                [item setBased];
//            }
        }
    }
    if (selectedItem != nil && onChangeCallbacks != nil) {
        for(OnChangeCallback cb in onChangeCallbacks) {
            cb(selectedItem);
        }
    }
}

/* setActives是排他性的 没有回调 */
-(void)setActives:(NSArray<NSIndexPath*>*) indexPaths {
    for(NSView *view in self.collectionView.subviews){
        if([view isKindOfClass:[NVToggleBox class]]) {
            NVToggleBox *item = view;
            BOOL find = NO;
            for(NSIndexPath * indexPath in indexPaths) {
                if ([indexPath isEqual: item.indexPath]) {
                    find = YES;
                }
            }
            if (find) {
                if (!item.isSelected) {
                    [item setSelected];
                }

            } else {
                [item setBased];
            }
        }
    }
}

/* 有回调 */
-(void)clearActive {
    for(NSView *view in self.collectionView.subviews){
        if([view isKindOfClass:[NVToggleBox class]]) {
            [(NVToggleBox *)view setBased];
        }
    }
    for(OnChangeCallback cb in onChangeCallbacks) {
        cb(nil);
    }
};

-(void)onChange:(OnChangeCallback) onChangeCallback {
    if (onChangeCallbacks == nil) onChangeCallbacks = [NSMutableArray new];
    [onChangeCallbacks addObject:onChangeCallback];
}

@end
