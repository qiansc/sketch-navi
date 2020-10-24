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
    NSLayoutConstraint* wrapperConstraint;
    float tm;
    float width, height0, height1;
}

-(void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    [self setWrapperHeight:1];
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

- (void)reloadData {
    [self resetHeaders];
    [super reloadData];
}

- (void)setWrapperHeight:(float) height {
    float ct = [[NSDate date]timeIntervalSince1970] * 1000;
    NSScrollView *scrollView = [self enclosingScrollView];
    if (ct - tm < 100) {
        if (width != scrollView.frame.size.width) {
            
        } else if (height != height0 && height != height1){
            
        } else {
            return;
        }
    }
    // NSLog(@"NAVIL CollectionView setWrapperHeight: %f %f %f %f %f %f" , height, width, height0, height1, [self enclosingScrollView].frame.size.width, [self enclosingScrollView].frame.size.height);
    width = scrollView.frame.size.width;
    height0 = height1;
    height1 = height;
    tm = ct;
    


    if (wrapperConstraint) {
        [scrollView removeConstraint:wrapperConstraint];
    }
    wrapperConstraint = [scrollView.heightAnchor constraintEqualToConstant: height];
    [scrollView addConstraint:wrapperConstraint];
}

@end
