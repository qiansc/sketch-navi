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
    NSRect r = self.view.frame;
    [super viewDidLayout];
    // Solution.002 保持superview高度和内容一致 Collection 始终保持无滚动条全展开状态
    NSCollectionView *view = (NSCollectionView *)self.view;
    NSSize s = [view collectionView:view layout:view.collectionViewLayout referenceSizeForFooterInSection:0];
    float  H = 0;
    for(NSView *v in self.view.subviews) {
        float h = v.frame.size.height + v.frame.origin.y + s.height;
        H = h > H ? h : H;
    }
    H = H < 100 ? self.view.frame.size.height : H;
    
    if (height != H || width != r.size.width) {
        height = H;
        width = r.size.width;
        self.view.frame = NSMakeRect(r.origin.x, r.origin.y, width, H);
        // Solution.003 同步高度到wrapper
        [self.wrapper setHeight:H];
        if (self.afterResize) {
            // Solution.003 同步高度到其他关心的容器
            self.afterResize(width, H);
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
