//
//  NVFontPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "HexColor.h"
#import "NVFontPanel.h"
#import "NVFontSource.h"
#import "NVFontCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVFontPanel ()

@end

@implementation NVFontPanel

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
            [self applySpecToSelections: ((NVFontCollectionItemView *)box).spec];
            [self updateTitle: ((NVFontCollectionItemView *)box).spec.code];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
    // 切换模式
    [self.modeButton setTarget:self];
    [self.modeButton setAction:@selector(modeButtonClick:)];
}

-(void)modeButtonClick:(NSSegmentedControl*) button{
    // [self.collectionView.source setMode: button.selectedSegment];
}

-(void)updateTitle:(NSString*) title{
    self.headerView.controller.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    if (layers != nil && layers.firstLayer != nil){
        [self.collectionView.dataSource setShapeMode:[layers.firstLayer className]];
    }

    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for(MSLayer *layer in layers) {
        if (![NVLayer isTextLayer:layer]){
            continue;
        }
       NSString* fontCode = [NVUserInfo fromLayer:layer].fontCode;
        // for(NSString *textCode in textCodes) {
            for(NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVToggleBox class]]) {
                    NVFontCollectionItemView *item = ((NVFontCollectionItemView *)view);
                    if([item.spec.code isEqual:fontCode]) {
                        // 找到和specCode对应的indexPath
                        [indexPaths addObject: item.indexPath];
                        // 校准一下颜色s
                        // [self applyColor:NSColorFromRGBString(item.spec.defaultColor) toLayer:layer];
                        [self applyFontSize:item.spec.iosFontSize toLayer:layer];
                        title = item.spec.code;
                    }
                }
            }
        // }
    }
    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count == 1) // 当选中项>2时候 不显示title
            [self updateTitle:title];
    }
}

/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVFontSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if ([NVLayer isTextLayer:layer]) {
                [NVUserInfo fromLayer:layer].fontCode = spec.code;
            }
            // [self applyColor:NSColorFromRGBString(spec.defaultColor) toLayer:layer];
            [self applyFontSize:spec.iosFontSize toLayer:layer];
        }
    }
}

/* 应用color到图层上 */
-(void)applyFontSize:(double) fontSize toLayer:(MSLayer*) layer{
    if ([NVLayer isTextLayer:layer]) {
        layer.fontSize = fontSize;
        layer.lineHeight = fontSize;
        // layer.font = [NSFont systemFontOfSize:fontSize weight:fontWeight];
    }
}


/* 应用color到图层上 */
-(void)applyColor:(NSColor*) color toLayer:(MSLayer*) layer{
    if ([NVLayer isTextLayer:layer]) {
        MSColor *c = layer.textColor;
        c.red = color.redComponent;
        c.green = color.greenComponent;
        c.blue = color.blueComponent;
        layer.textColor = c;
    }
}


@end
