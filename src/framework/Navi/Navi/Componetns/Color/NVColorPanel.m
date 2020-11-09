//
//  NVColorPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "HexColor.h"
#import "NVColorPanel.h"
#import "NVColorSource.h"
#import "NVColorCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVColorPanel ()

@end

@implementation NVColorPanel {
    // NVColorSpec spec;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.toggleDelegate afterReload:^(void){
        // 一般是数据更新时 整体重绘 需要根据选中项重新选择
         [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        // 选择变化时 应用到selections 且改更新title
        if (box == nil) {
            [self updateTitle:nil];
        }else{
            [self applySpecToSelections: ((NVColorCollectionItemView *)box).spec];
            [self updateTitle: ((NVColorCollectionItemView *)box).spec.specCode];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
    // 切换模式
    [self.modeButton setTarget:self];
    [self.modeButton setAction:@selector(modeButtonClick:)];
}

-(void)modeButtonClick:(NSSegmentedControl*) button{
    [self.collectionView.dataSource setMode: button.selectedSegment];
}

-(void)updateTitle:(NSString*) title{
    self.headerView.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    if (layers != nil && layers.firstLayer != nil){
        self.collectionView.dataSource.shapeType = [layers.firstLayer className];
    }

    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for(MSLayer *layer in layers) {
        NSString *colorCode;
        NVUserInfo *info = [NVUserInfo fromLayer:layer];
        if (self.collectionView.dataSource.isTextType) {
            colorCode = info.fontColorCode;
        } else if (self.collectionView.dataSource.isFillMode) {
            colorCode = info.fillColorCode;
        } else if (self.collectionView.dataSource.isBorderMode) {
            colorCode = info.borderColorCode;
        }
        
        for(NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVColorCollectionItemView *item = ((NVColorCollectionItemView *)view);
                if([item.spec.specCode isEqual:colorCode]) {
                    // 找到和specCode对应的indexPath
                    [indexPaths addObject: item.indexPath];
                    // 校准一下颜色s
                    [self applyColor:NSColorFromRGBString(item.spec.hex) toLayer:layer];
                    title = item.spec.specCode;
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
            NVUserInfo *info = [NVUserInfo fromLayer:layer];
            if (self.collectionView.dataSource.isTextType) {
                info.fontColorCode = spec.specCode;
            } else if (self.collectionView.dataSource.isFillMode && layer.style.fills) {
                info.fillColorCode = spec.specCode;
            } else if (self.collectionView.dataSource.isBorderMode && layer.style.borders) {
                info.borderColorCode = spec.specCode;
            }
            [self applyColor:NSColorFromRGBString(spec.hex) toLayer:layer];
        }
    }
}
/* 应用color到图层上 */
-(void)applyColor:(NSColor*) color toLayer:(MSLayer*) layer{
    if (self.collectionView.dataSource.isTextType) {
        MSColor *c = layer.textColor;
        c.red = color.redComponent;
        c.green = color.greenComponent;
        c.blue = color.blueComponent;
        layer.textColor = c;
    } else if (self.collectionView.dataSource.isFillMode && layer.style.fills) {
        for(MSStyleFill *fill in layer.style.fills) {
            fill.color.red = color.redComponent;
            fill.color.green = color.greenComponent;
            fill.color.blue = color.blueComponent;
        }
    } else if (self.collectionView.dataSource.isBorderMode && layer.style.borders) {
        for(MSStyleBorder *border in layer.style.borders) {
            border.color.red = color.redComponent;
            border.color.green = color.greenComponent;
            border.color.blue = color.blueComponent;
        }
    }
}

@end
