//
//  NVCollectionDelegate.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCollectionDelegate.h"

@implementation NVCollectionDelegate

-(void)setActive:(NSIndexPath *)indexPath {
    for(NSView *view in self.collectionView.subviews){
        if([view isKindOfClass:[NVToggleBox class]]) {
            NVToggleBox *item = view;
            if ([indexPath isEqual: item.indexPath]) {
                [item setSelected];
            } else {
                [item setBased];
            }
        }
    }
};

@end
