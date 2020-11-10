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
-(instancetype)initWithCoder:(NSCoder *)coder{
    NVCollectionView *view = [super initWithCoder:coder];
    view.toggleDelegate = [NVCollectionDelegate new];
    view.toggleDelegate.collectionView = view;
    return view;
}



-(void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}


- (void)reloadData {
//    [self resetHeaders];
    [super reloadData];
    // 这里必须加一个timer 不然collectionView没来得及更新 正常时序解不了
    if (self.toggleDelegate) {
        [NSTimer scheduledTimerWithTimeInterval:0 target:self.toggleDelegate selector:@selector(triggerAfterReload) userInfo:nil repeats:NO];
    }

    
}

-(float)displayHeight{
    float  maxBottom = 1;
    for(NSView *view in self.subviews) {
        if (view.isHidden == NO) {
            float h = view.frame.size.height + view.frame.origin.y; // + s.height;
            maxBottom = h > maxBottom ? h : maxBottom;
        }
    }
    return maxBottom;
}



@end
