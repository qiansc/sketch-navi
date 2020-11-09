//
//  NVMarginPanel.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMarginPanel.h"
#import "NVMarginSource.h"
#import "NVMarginCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "MSDocument.h"

@interface NVMarginPanel ()

@end

@implementation NVMarginPanel {
    NSMutableArray *selectedSpecs;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedSpecs = [NSMutableArray new];
    [selectedSpecs addObject:@""];[selectedSpecs addObject:@""];[selectedSpecs addObject:@""];[selectedSpecs addObject:@""];
    [self.collectionView.toggleDelegate afterReload:^(void){
        // 一般是数据更新时 整体重绘 需要根据选中项重新选择
        [self selectionChange:self.selections];
    }];
    
    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        // 选择变化时 应用到selections 且改更新title
        if (box == nil) {
            [self updateTitle];
        }else{
            NVMarginSpec spec = ((NVMarginCollectionItemView *)box).spec;
            
            if ([(MSLayerArray *)self.selections layerAtIndex:1] == nil) {
                if (![selectedSpecs[spec.pos] isEqual:spec.code]) {
                    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"请选择2个图层再进行操作！"]];
                    [self restoreActive];
                    return;
                }
            }
            
            if ([selectedSpecs[spec.pos] isEqual:spec.code]) {
                [box setBased];
                selectedSpecs[spec.pos] = @"";
                NVMarginSpec s = {
                    .code = nil,
                    .pos = spec.pos
                };
                [self applySpecToSelections: s];
                [self updateTitle];
            } else {
                selectedSpecs[spec.pos] =  spec.code;
                [self applySpecToSelections: spec];
                [self updateTitle];

            }
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle];
}

-(void)updateTitle{
    NSMutableArray *arr = [NSMutableArray new];
    if (((NSString *)selectedSpecs[0]).length > 0) {
        [arr addObject:selectedSpecs[0]];
    }
    if (((NSString *)selectedSpecs[1]).length > 0) {
        [arr addObject:selectedSpecs[1]];
    }
    if (((NSString *)selectedSpecs[2]).length > 0) {
        [arr addObject:selectedSpecs[2]];
    }
    if (((NSString *)selectedSpecs[3]).length > 0) {
        [arr addObject:selectedSpecs[3]];
    }
    if ([arr count] > 0) {
        self.headerView.infoButton.title = [arr componentsJoinedByString:@" "];
    } else {
        self.headerView.infoButton.title = nil;
    }
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    selectedSpecs[0] = @"";selectedSpecs[1] = @"";selectedSpecs[2] = @"";selectedSpecs[3] = @"";
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    // if ([layers layerAtIndex:1] != nil) {
        // MSLayer *target = [layers layerAtIndex:0];
    MSLayer *layer = [layers layerAtIndex:1];
    if (layer == nil)
        layer = [layers layerAtIndex:0];
        // for (MSLayer *layer in layers) {
        if ([NVLayer isShape:layer]) {

            NSString *marginTopCode =[NVUserInfo fromLayer:layer].marginTopCode;
            NSString *marginRightCode =[NVUserInfo fromLayer:layer].marginRightCode;
            NSString *marginBottomCode =[NVUserInfo fromLayer:layer].marginBottomCode;
            NSString *marginLeftCode =[NVUserInfo fromLayer:layer].marginLeftCode;
            
            for (NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVMarginCollectionItemView class]]) {
                    NVMarginCollectionItemView *item = ((NVMarginCollectionItemView *) view);
                    if ([item.spec.code isEqual:marginTopCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                        // [self applyWidth:item.spec.ios toLayer:layer];
                        // layer.frame.width = item.spec.ios;
                    }
                    if ([item.spec.code isEqual:marginRightCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                    }
                    if ([item.spec.code isEqual:marginBottomCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                    }
                    if ([item.spec.code isEqual:marginLeftCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                    }
                }
            }
        }
        // }
        
    // }
     [self applySpec];
    [self.collectionView.toggleDelegate clearActive];
    if (indexPaths.count > 0) {
        [self.collectionView.toggleDelegate setActives:indexPaths];
        if (indexPaths.count <3) {
            [self updateTitle];
        }
    }
    
}
/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVMarginSpec) spec {
    if (self.selections) {
        MSLayer *layer = [self.selections layerAtIndex:1];
        if (layer == nil)
            layer = [self.selections layerAtIndex:0];
        
//        for(MSLayer *layer in self.selections) {
        if ([NVLayer isShape:layer]){
            switch (spec.pos) {
                case 0:
                    [NVUserInfo fromLayer:layer].marginTopCode = spec.code;
                    break;
                case 1:
                    [NVUserInfo fromLayer:layer].marginRightCode = spec.code;
                    break;
                case 2:
                    [NVUserInfo fromLayer:layer].marginBottomCode = spec.code;
                    break;
                case 3:
                    [NVUserInfo fromLayer:layer].marginLeftCode = spec.code;
                    break;
                default:
                    break;
            }
        }

    }
    [self restoreActive];
    [self applySpec];
}

-(void)restoreActive {
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    for (NSView *view in self.collectionView.subviews) {
        if ([view isKindOfClass:[NVMarginCollectionItemView class]]) {
            NVMarginCollectionItemView *item = ((NVMarginCollectionItemView *) view);
            if ([item.spec.code isEqual:selectedSpecs[0]] || [item.spec.code isEqual:selectedSpecs[1]] || [item.spec.code isEqual:selectedSpecs[2]] || [item.spec.code isEqual:selectedSpecs[3]]) {
                [indexPaths addObject:item.indexPath];
            }
        }
    }
    [self.collectionView.toggleDelegate setActives:indexPaths];
}

-(void)applySpec{
    [self applyTop];
    [self applyRight];
    [self applyBottom];
    [self applyLeft];

}

-(void)applyLeft{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVMarginSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[3]];
    if (spec.code == nil) return;
    layer.frame.x = target.frame.x + spec.ios;
}

-(void)applyTop{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVMarginSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[0]];
    if (spec.code == nil) return;
    layer.frame.y = target.frame.y + spec.ios;
}
-(void)applyRight{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVMarginSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[1]];
    NVMarginSpec leftSpec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[3]];
    if (spec.code == nil) return;
    if (leftSpec.code != nil) {
        if ([NVUserInfo fromLayer:layer].gridWidthCode) {
            [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"存在栅格宽度编码 %@ ，请先移除！", [NVUserInfo fromLayer:layer].gridWidthCode]];
            return;
        }
        layer.frame.width = target.frame.width - spec.ios - leftSpec.ios;
    }
    layer.frame.x = target.frame.x + target.frame.width - layer.frame.width - spec.ios;
}
-(void)applyBottom{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVMarginSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[2]];
    NVMarginSpec topSpec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[0]];
    if (spec.code == nil) return;
    if (topSpec.code != nil) {
        if ([NVUserInfo fromLayer:layer].gridScaleCode) {
            [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"存在栅格高度编码 %@ ，请先移除！", [NVUserInfo fromLayer:layer].gridScaleCode]];
            return;
        }
        layer.frame.height = target.frame.height - spec.ios - topSpec.ios;
    }
    layer.frame.y = target.frame.y + target.frame.height - layer.frame.height - spec.ios;
}

@end
