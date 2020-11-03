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
    self.headerView.infoButton.title = title;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    
}
/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVBorderSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
//            if ([[layer className] isEqual:@"MSTextLayer"]) {
//                 [NVLayer set:layer textCode:spec.code];
//            }
//            [self applyColor:NSColorFromRGBString(spec.defaultColor) toLayer:layer];
//            [self applyFontSize:spec.iosFontSize weight:spec.iosFont toLayer:layer];
        }
    }
}
@end
