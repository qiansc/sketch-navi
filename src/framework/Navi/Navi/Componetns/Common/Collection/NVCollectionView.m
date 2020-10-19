//
//  NVCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCollectionView.h"

/* 主要解决Header、Footer View绘制时进程卡死问题 */
@implementation NVCollectionView {
        NSMutableDictionary* headers;
}

-(void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    [self resetHeaders];
}

- (void)resetHeaders {
    for(NSView* header in [headers allValues]) {
        [header removeFromSuperview];
    };
    [headers removeAllObjects];
    [headers dealloc];
    headers = [[NSMutableDictionary alloc]init];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

- (__kindof NSView *)makeSupplementaryViewOfKind:(NSCollectionViewSupplementaryElementKind)elementKind withIdentifier:(NSUserInterfaceItemIdentifier)identifier forIndexPath:(NSIndexPath *)indexPath {
    // Solution.005 判断是Header Footer 通过缓存机制来保证入场、销毁
    if (elementKind == NSCollectionElementKindSectionHeader || elementKind == NSCollectionElementKindSectionFooter) {
        NSString *key = [NSString stringWithFormat:@"P%@-%ld", elementKind, (long)indexPath.section];
        NSView *oldview = headers[key];
        if (oldview != nil) {
            [oldview removeFromSuperview];
        }
        NSView *view = [super makeSupplementaryViewOfKind:elementKind withIdentifier:identifier forIndexPath:indexPath];
        [headers setObject:view forKey:key];
        return view;
    } else {
        return [super makeSupplementaryViewOfKind:elementKind withIdentifier:identifier forIndexPath:indexPath];
    }
}

@end
