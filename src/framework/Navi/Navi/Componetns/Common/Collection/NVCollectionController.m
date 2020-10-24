//
//  NVCollectionController.m
//  Navi
//
//  Created by QIANSC on 2020/10/19.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVCollectionController.h"


@interface NVCollectionController ()

@end

@implementation NVCollectionController
{
    float height, width;
}

-(void)setCollectionView:(NSCollectionView *) view{
    self.view = view;
    self.clipView = view.superview;
    self.wrapper = self.clipView.superview;
}

- (void)viewDidLayout {
    [super viewDidLayout];
    // Solution.002 保持superview高度和内容一致 Collection 始终保持无滚动条全展开状态
    NSCollectionView *view = (NSCollectionView *)self.view;
    NSSize s = [view collectionView:view layout:view.collectionViewLayout referenceSizeForFooterInSection:0];
    float  maxBottom = 0;
    float  maxVisableBottom = 0;
    float w = self.view.frame.size.width;
    for(NSView *v in self.view.subviews) {

        float h = v.frame.size.height + v.frame.origin.y + s.height;
        maxBottom = h > maxBottom ? h : maxBottom;
        if (!v.isHidden) {
            maxVisableBottom = h > maxVisableBottom ? h : maxVisableBottom;
        }
    }
    if (height != maxVisableBottom || width != w) {
        if (self.afterResize) {
            height = maxVisableBottom;
            width = w;
            [self.view setWrapperHeight:maxVisableBottom];
            // Solution.003 同步高度到其他关心的容器
            self.afterResize(width, maxVisableBottom);
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

+ (void)initWithNVPanelController {

}

@end
