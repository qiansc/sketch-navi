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
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}


- (void)reloadData {
//    [self resetHeaders];
    [super reloadData];
    // 这里必须加一个timer 不然collectionView没来得及更新 正常时序解不了
//    if (self.toggleDelegate) {
//            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.toggleDelegate selector:@selector(triggerAfterReload) userInfo:nil repeats:NO];
//    }

    
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

//- (void)setWrapperHeight:(float) height {
//    float ct = [[NSDate date]timeIntervalSince1970] * 1000;
//    NSScrollView *scrollView = [self enclosingScrollView];
//    if (ct - tm < 100) {
//        if (width != scrollView.frame.size.width) {
//            
//        } else if (height != height0 && height != height1){
//            
//        } else {
//            return;
//        }
//    }
//    // NSLog(@"NAVIL CollectionView setWrapperHeight: %f %f %f %f %f %f" , height, width, height0, height1, [self enclosingScrollView].frame.size.width, [self enclosingScrollView].frame.size.height);
//    width = scrollView.frame.size.width;
//    height0 = height1;
//    height1 = height;
//    tm = ct;
//
//    if (wrapperConstraint) {
//        [scrollView removeConstraint:wrapperConstraint];
//    }
//    NSRect frame = scrollView.frame;
//    scrollView.frame = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, height);
//    wrapperConstraint = [scrollView.heightAnchor constraintEqualToConstant: height];
//    [scrollView addConstraint:wrapperConstraint];
//
//    
//}

@end
