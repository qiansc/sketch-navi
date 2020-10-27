//
//  NVTextPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "HexColor.h"
#import "NVTextPanel.h"
#import "NVCollectionController.h"
#import "NVTextSource.h"
#import "NVTextCollectionItemView.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVTextPanel ()

@end

@implementation NVTextPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建NVCollectionController 并把他的视图指向到xib存在的那个collectionView上去
    NVCollectionController *c = [[NVCollectionController alloc]init];
    [c setCollectionView: self.collectionView];
    // 绑定重绘
    c.afterResize = ^(float width, float height) {
         [self resetConstraint];
    };

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
//    for(MSLayer *layer in layers) {
//        NSArray<NSString*>* colorCodes = self.modeButton.selectedSegment ? [NVLayer getBordersColorCodeIn:layer] : [NVLayer getFillsColorCodeIn:layer];
//        for(NSString *colorCode in colorCodes) {
//            for(NSView *view in self.collectionView.subviews) {
//                if ([view isKindOfClass:[NVTextCollectionItemView class]]) {
//                    NVTextCollectionItemView *item = ((NVTextCollectionItemView *)view);
//                    if([item.spec.code isEqual:colorCode]) {
//                        // 找到和specCode对应的indexPath
//                        [indexPaths addObject: item.indexPath];
//                        // 校准一下颜色s
//                        [self applyColor:NSColorFromRGBString(item.spec.hex) toLayer:layer];
//                        title = item.spec.specCode;
//                    }
//                }
//            }
//        }
//    }
    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count == 1) // 当选中项>2时候 不显示title
            [self updateTitle:title];
    }


}

/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVTextSpec) spec {
//    if (self.selections) {
//        for(MSLayer *layer in self.selections) {
//            if ([[layer className] isEqual:@"MSTextLayer"]) {
//                [NVLayer set:layer textColorCode:spec.specCode];
//            } else if (self.modeButton.selectedSegment == 0 && layer.style.fills) {
//                for(NSInteger i = 0; i < [layer.style.fills count]; i++) {
//                    [NVLayer set:layer fillColorCode:spec.specCode at: i];
//                }
//            } else if (self.modeButton.selectedSegment == 1 && layer.style.borders) {
//                for(NSInteger i = 0; i < [layer.style.borders count]; i++) {
//                    [NVLayer set:layer borderColorCode:spec.specCode at: i];
//                }
//            }
//            [self applyColor:NSColorFromRGBString(spec.hex) toLayer:layer];
//        }
//    }
}
/* 应用color到图层上 */
-(void)applyColor:(NSColor*) color toLayer:(MSLayer*) layer{
//    if ([[layer className] isEqual:@"MSTextLayer"]) {
//        MSColor *c = layer.textColor;
//        c.red = color.redComponent;
//        c.green = color.greenComponent;
//        c.blue = color.blueComponent;
//        layer.textColor = c;
//    } else if (self.modeButton.selectedSegment == 0 && layer.style.fills) {
//        for(MSStyleFill *fill in layer.style.fills) {
//            fill.color.red = color.redComponent;
//            fill.color.green = color.greenComponent;
//            fill.color.blue = color.blueComponent;
//        }
//    } else if (self.modeButton.selectedSegment == 1 && layer.style.borders) {
//        for(MSStyleBorder *border in layer.style.borders) {
//            border.color.red = color.redComponent;
//            border.color.green = color.greenComponent;
//            border.color.blue = color.blueComponent;
//        }
//    }
}

- (void)setSemanticMode:(BOOL)mode {
    [super setSemanticMode:mode];
    self.collectionView.semanticMode = mode;
    [self.collectionView reloadData];
}

@end
