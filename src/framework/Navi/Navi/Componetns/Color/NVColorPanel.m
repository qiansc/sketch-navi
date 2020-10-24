//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorPanel.h"
#import "NVCollectionController.h"
#import "NVColorSource.h"
#import "NVColorCollectionItemView.h"
#import "HexColor.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel {
    // NVColorSpec spec;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建NVCollectionController 并把他的视图指向到xib存在的那个collectionView上去
    NVCollectionController *c = [[NVCollectionController alloc]init];
    [c setCollectionView: self.collectionView];
    // 绑定重绘
    c.afterResize = ^(float width, float height) {
         [self resetConstraint];
    };
    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        if (box == nil) {
            [self updateTitle:nil];
        }else{
            [self applySpecToSelections: ((NVColorCollectionItemView *)box).spec];
            [self updateTitle: ((NVColorCollectionItemView *)box).spec.specCode];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
}


-(void)updateTitle:(NSString*) title{
    self.headerView.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.source;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers {
    /*下面代码临时实现 还要重构 */
    // NSIndexPath *indexPath = nil;
    self.selections = layers;
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for(MSLayer *layer in layers) {
        if(layer.userInfo && layer.userInfo[@"colorCode"]) {
            NSString *colorCode = layer.userInfo[@"colorCode"];
            for(NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVColorCollectionItemView class]]) {
                    NVColorCollectionItemView *item = ((NVColorCollectionItemView *)view);
                    if([item.spec.specCode isEqual:colorCode]) {
                        // 找到和specCode对应的indexPath
                        [indexPaths addObject: item.indexPath];
                        // 校准一下颜色
                        [self applyColor:NSColorFromRGBString(item.spec.hex) toLayer:layer];
                        title = item.spec.specCode;
                    }
                }
            }
        }
    }

    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count == 1) // 当选中项>2时候 不显示title
            [self updateTitle:title];
    }
        

}

/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVColorSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            [self applySpec:spec toLayer:layer];
        }
    }
}

/* 应用spec到图层上 */
-(void)applySpec:(NVColorSpec) spec toLayer:(MSLayer*) layer{
    NSMutableDictionary *d = [NSMutableDictionary new];
    d[@"colorCode"] = spec.specCode;
    layer.userInfo = d;
    [self applyColor:NSColorFromRGBString(spec.hex) toLayer:layer];

}

/* 应用color到图层上 */
-(void)applyColor:(NSColor*) color toLayer:(MSLayer*) layer{
    if (layer.style.fills[0]) {
        layer.style.fills[0].color.red = color.redComponent;
        layer.style.fills[0].color.green = color.greenComponent;
        layer.style.fills[0].color.blue = color.blueComponent;
    }
}

@end
