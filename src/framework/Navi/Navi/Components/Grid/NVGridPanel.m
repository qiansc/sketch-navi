//
//  NVGridPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVGridPanel.h"
#import "NVGridSource.h"
#import "NVGridCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVGridPanel ()

@end

@implementation NVGridPanel {
    NVGridSpec widthSpec;
    NVGridSpec scaleSpec;
    
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
            [self updateTitle];
        } else {
            NVGridSpec spec = ((NVGridCollectionItemView *)box).spec;
            NVGridSpec empty = {
                .code = nil,
                .cclass = spec.cclass,
            };

            if ([spec.cclass isEqual:@"比例"]) {
                if ([scaleSpec.code isEqual:spec.code]) {
                    [box setBased];
                    scaleSpec.code = nil;
                    [self applySpecToSelections: empty];
                } else {
                    scaleSpec = spec;
                    [self applySpecToSelections: spec];
                }
            } else {
                if ([widthSpec.code isEqual:spec.code]) {
                    [box setBased];
                    widthSpec.code = nil;
                    [self applySpecToSelections: empty];
                } else {
                    widthSpec = spec;
                    [self applySpecToSelections: spec];
                }
            }
            
            [self updateTitle];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle];
}

-(void)updateTitle{
    NSString *title = nil;
    if (widthSpec.code && scaleSpec.code) {
        title = [NSString stringWithFormat:@"%@ - %@", widthSpec.code, scaleSpec.code];
    } else if (widthSpec.code) {
        title =  widthSpec.code;
    } else if (scaleSpec.code){
        title =  scaleSpec.code;
    }
    self.headerView.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    widthSpec.code = nil;
    scaleSpec.code = nil;
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    for (MSLayer *layer in layers) {
        if (![NVLayer isShape:layer]) continue;
        NSString *gridWidthCode =[NVUserInfo fromLayer:layer].gridWidthCode;
        NSString *gridScaleCode =[NVUserInfo fromLayer:layer].gridScaleCode;
        
        
        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVGridCollectionItemView *item = ((NVGridCollectionItemView *) view);
                if ([item.spec.code isEqual:gridWidthCode]) {
                    [indexPaths addObject:item.indexPath];
                    widthSpec = item.spec;
                    [self applyWidth:item.spec.ios toLayer:layer];
                    layer.frame.width = item.spec.ios;
                }

                if ([item.spec.code isEqual:gridScaleCode]) {
                    [indexPaths addObject:item.indexPath];
                     scaleSpec = item.spec;
                    [self applyScale:item.spec.scale toLayer:layer];
                }
            }
        }
    }
    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count <3) {
            [self updateTitle];
        }
    }
    
}
/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVGridSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if (![NVLayer isShape:layer]) continue;
            if ([spec.cclass isEqual:@"比例"]) {
                [NVUserInfo fromLayer:layer].gridScaleCode = spec.code;
                [self applyScale:spec.scale toLayer:layer];
            } else {
                [NVUserInfo fromLayer:layer].gridWidthCode = spec.code;
                [self applyWidth:spec.ios toLayer:layer];
            }
        }
    }
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    for (NSView *view in self.collectionView.subviews) {
        if ([view isKindOfClass:[NVToggleBox class]]) {
            NVGridCollectionItemView *item = ((NVGridCollectionItemView *) view);
            if ([item.spec.code isEqual:widthSpec.code] || [item.spec.code isEqual:scaleSpec.code]) {
                [indexPaths addObject:item.indexPath];
            }
        }
    }
    [self.collectionView.toggleDelegate setActives:indexPaths];
}

-(void)applyWidth:(double) width toLayer:(MSLayer*) layer{
    layer.frame.width = width;
    if (scaleSpec.code) {
        [self applyScale:scaleSpec.scale toLayer:layer];
    }
}

-(void)applyScale:(NSString*) scale toLayer:(MSLayer*) layer{
    NSArray* arr = [scale componentsSeparatedByString:@":"];
    double width = [arr[0] doubleValue];
    double height = [arr[1] doubleValue];
    layer.frame.height = round(layer.frame.width * 100 * height / width) / 100;
}

@end
