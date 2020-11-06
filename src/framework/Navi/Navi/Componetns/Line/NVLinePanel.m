//
//  NVLinePanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLinePanel.h"
#import "NVLineSource.h"
#import "NVLineCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@implementation NVLinePanel

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.toggleDelegate afterReload:^(void){
        [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox *box) {
        if (box == nil) {
            [self updateTitle:nil];
        } else {
            [self applySpecToSelections:((NVLineCollectionItemView *) box).spec];
            [self updateTitle:((NVLineCollectionItemView *) box).spec.specCode];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
}

- (void)updateTitle:(NSString*) title{
    self.headerView.infoButton.title = title;
}

- (NSObject<NVSource> *)generatePanelSource {
    return self.collectionView.dataSource;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers{
    // 保存当前被选中的layers
    self.selections = layers;
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for (MSLayer *layer in layers) {
        NSString *borderThicknessCode =[NVUserInfo fromLayer:layer].borderThicknessCode;;

        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVLineCollectionItemView class]]) {
                NVLineCollectionItemView *item = ((NVLineCollectionItemView *) view);
                if ([item.spec.specCode isEqual:borderThicknessCode]) {
                    [indexPaths addObject:item.indexPath];
                    [self applyLine:item.spec.weight toLayer:layer];
                    title = item.spec.specCode;
                }
            }
        }
    }
    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count == 1) {
            [self updateTitle:title];
        }
    }
}

- (void) applySpecToSelections:(NVLineSpec)spec {
    if (self.selections) {
        for (MSLayer *layer in self.selections) {
            NVUserInfo *info = [NVUserInfo fromLayer:layer];
            if ([NVLayer isShapePathLayer:layer] || [NVLayer isShape:layer]) {
                info.borderThicknessCode = spec.specCode;
                [self applySpec:spec toLayer:layer];
            }
        }
    }
}

- (void) applySpec:(NVLineSpec) spec toLayer:(MSLayer *) layer {
    [self applyLine:spec.weight toLayer:layer];
}

- (void)applyLine:(NSString *) lineWeight toLayer:(MSLayer *) layer {
    if ([NVLayer isShapePathLayer:layer] || [NVLayer isShape:layer]) {
        for (MSStyleBorder *border in layer.style.borders) {
            border.thickness = [(NSNumber *)lineWeight doubleValue];
        }
    }
}

//- (int)height {
//    int superHeight = [super height];
//    return superHeight + 20;
//}

@end
