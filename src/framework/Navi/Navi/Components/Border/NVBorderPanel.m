//
//  NVBorderPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVBorderPanel.h"
#import "NVBorderSource.h"
#import "NVBorderCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVBorderPanel ()

@end

@implementation NVBorderPanel

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
            [self applySpecToSelections: ((NVBorderCollectionItemView *)box).spec];
            [self updateTitle: ((NVBorderCollectionItemView *)box).spec.code];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
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
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for (MSLayer *layer in layers) {
        if (![NVLayer isRectangleShape:layer]) continue;
        NSString *cornerRadiusCode =[NVUserInfo fromLayer:layer].cornerRadiusCode;
        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVBorderCollectionItemView *item = ((NVBorderCollectionItemView *) view);
                if ([item.spec.code isEqual:cornerRadiusCode]) {
                    [indexPaths addObject:item.indexPath];
                    [self applyCornerRadius:item.spec.ios toLayer:layer];
                    title = item.spec.code;
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
/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVBorderSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if (![NVLayer isRectangleShape:layer]) continue;
            [NVUserInfo fromLayer:layer].cornerRadiusCode = spec.code;
            [self applyCornerRadius:spec.ios toLayer:layer];
        }
    }
}

-(void)applyCornerRadius:(NSString *) radiusString toLayer:(MSLayer*) layer{
    NSArray<NSString*> *arr = [radiusString componentsSeparatedByString:@","];
    int index = 0;
    for(MSCurvePoint *point in layer.points) {
        if (arr[index]) {
            float num = [arr[index] doubleValue];
            if (num == -1) {
                point.cornerRadius = MAX(layer.frame.width, layer.frame.height)/2;
            } else {
                point.cornerRadius = num;
            }
        } else {
            point.cornerRadius = 0;
        }
        index++;
    }
}

@end
