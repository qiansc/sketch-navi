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

-(void)setActive:(NSIndexPath *)indexPath {
    NVToggleBox *selectedItem;
    for(NSView *view in self.collectionView.subviews){
        if([view isKindOfClass:[NVToggleBox class]]) {
            NVToggleBox *item = view;
            if ([indexPath isEqual: item.indexPath]) {
                [item setSelected];
                 selectedItem = item;
            } else {
                [item setBased];
            }
        }
    }
    if (selectedItem != nil && onChangeCallbacks != nil) {
        for(OnChangeCallback cb in onChangeCallbacks) {
            cb(selectedItem);
        }
    }
};

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
