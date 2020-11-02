//
//  NVTextPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "HexColor.h"
#import "NVTextPanel.h"
#import "NVTextSource.h"
#import "NVTextCollectionItemView.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVTextPanel ()

@end

@implementation NVTextPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.toggleDelegate afterReload:^(void){
//         NSLog(@"NAVIL PPPPP %@", self);
        // 一般是数据更新时 整体重绘 需要根据选中项重新选择
         [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        // 选择变化时 应用到selections 且改更新title
        if (box == nil) {
            [self updateTitle:nil];
        }else{
            [self applySpecToSelections: ((NVTextCollectionItemView *)box).spec];
            [self updateTitle: ((NVTextCollectionItemView *)box).spec.code];
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
    self.headerView.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.source;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    if (layers != nil && layers.firstLayer != nil){
        [self.collectionView.source setShapeMode:[layers.firstLayer className]];
    }
    
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for(MSLayer *layer in layers) {
        if (![[layer className] isEqual:@"MSTextLayer"]){
            continue;
        }
        NSArray<NSString*>* textCodes = [NVLayer getTextCodeIn:layer];
        for(NSString *textCode in textCodes) {
            for(NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVTextCollectionItemView class]]) {
                    NVTextCollectionItemView *item = ((NVTextCollectionItemView *)view);
                    if([item.spec.code isEqual:textCode]) {
                        // 找到和specCode对应的indexPath
                        [indexPaths addObject: item.indexPath];
                        // 校准一下颜色s
                        [self applyColor:NSColorFromRGBString(item.spec.defaultColor) toLayer:layer];
                        [self applyFontSize:item.spec.iosFontSize weight:item.spec.iosFont toLayer:layer];
                        title = item.spec.code;
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
-(void)applySpecToSelections:(NVTextSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if ([[layer className] isEqual:@"MSTextLayer"]) {
                 [NVLayer set:layer textCode:spec.code];
            }
            [self applyColor:NSColorFromRGBString(spec.defaultColor) toLayer:layer];
            [self applyFontSize:spec.iosFontSize weight:spec.iosFont toLayer:layer];
        }
    }
}

/* 应用color到图层上 */
-(void)applyFontSize:(double) fontSize weight:(double) fontWeight toLayer:(MSLayer*) layer{
    if ([[layer className] isEqual:@"MSTextLayer"]) {
        layer.fontSize = fontSize;
        layer.font = [NSFont systemFontOfSize:fontSize weight:fontWeight];
    }
}


/* 应用color到图层上 */
-(void)applyColor:(NSColor*) color toLayer:(MSLayer*) layer{
    if ([[layer className] isEqual:@"MSTextLayer"]) {
        MSColor *c = layer.textColor;
        c.red = color.redComponent;
        c.green = color.greenComponent;
        c.blue = color.blueComponent;
        layer.textColor = c;
    }// fontSize //fontWeight
}

- (void)setSemanticMode:(BOOL)mode {
    [super setSemanticMode:mode];
    self.collectionView.semanticMode = mode;
    [self.collectionView reloadData];
}

@end
