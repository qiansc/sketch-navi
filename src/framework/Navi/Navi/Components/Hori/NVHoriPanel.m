//
//  NVHoriPanel.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVHoriPanel.h"
#import "NVHoriSource.h"
#import "NVHoriCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "MSDocument.h"

@interface NVHoriPanel ()

@end

@implementation NVHoriPanel {
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
            NVHoriSpec spec = ((NVHoriCollectionItemView *)box).spec;
            
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
                NVHoriSpec s = {
                    .code = nil,
                    .pos = spec.pos
                };
                [self applySpecToSelections: s];
                [self updateTitle];
            } else {
                MSLayer *layer = [(MSLayerArray *)self.selections layerAtIndex:1];
                MSLayer *target = [(MSLayerArray *)self.selections layerAtIndex:0];
                
                if ([self relationOf:layer and:target] == 0) {
                    switch (spec.pos) {
//                        case 0: selectedSpecs[2] = @""; [NVUserInfo fromLayer:layer].HoriBottomCode=nil;break;
//                        case 2: selectedSpecs[0] = @"";[NVUserInfo fromLayer:layer].HoriTopCode=nil;break;
//                        case 1: selectedSpecs[3] = @"";[NVUserInfo fromLayer:layer].HoriLeftCode=nil;break;
//                        case 3: selectedSpecs[1] = @"";[NVUserInfo fromLayer:layer].HoriRightCode=nil;break;
                        default:
                            break;
                    }
                }
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
        self.headerView.controller.infoButton.title = [arr componentsJoinedByString:@" "];
    } else {
        self.headerView.controller.infoButton.title = nil;
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

            NSString *MarginTopCode =[NVUserInfo fromLayer:layer].marginTopCode;
            NSString *MarginRightCode =[NVUserInfo fromLayer:layer].marginRightCode;
            NSString *MarginBottomCode =[NVUserInfo fromLayer:layer].marginBottomCode;
            NSString *MarginLeftCode =[NVUserInfo fromLayer:layer].marginLeftCode;
            
            for (NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVToggleBox class]]) {
                    NVHoriCollectionItemView *item = ((NVHoriCollectionItemView *) view);
                    if ([item.spec.code isEqual:MarginTopCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                        // [self applyWidth:item.spec.ios toLayer:layer];
                        // layer.frame.width = item.spec.ios;
                    }
                    if ([item.spec.code isEqual:MarginRightCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                    }
                    if ([item.spec.code isEqual:MarginBottomCode]) {
                        [indexPaths addObject:item.indexPath];
                        selectedSpecs[item.spec.pos] = item.spec.code;
                    }
                    if ([item.spec.code isEqual:MarginLeftCode]) {
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
-(void)applySpecToSelections:(NVHoriSpec) spec {
    // [self showAlert];
    if (self.selections) {
        MSLayer *layer = [self.selections layerAtIndex:1];
        MSLayer *target = [self.selections layerAtIndex:0];
        if (layer == nil) {
            target = nil;
            layer = [self.selections layerAtIndex:0];
        }
        
//        for(MSLayer *layer in self.selections) {
        if ([NVLayer isShape:layer]){
            switch (spec.pos) {
                case 0:
                    [NVUserInfo fromLayer:layer].marginTopTarget = target.objectID;
                    [NVUserInfo fromLayer:layer].marginTopCode = spec.code;
                    break;
                case 1:
                    [NVUserInfo fromLayer:layer].marginRightTarget = target.objectID;
                    [NVUserInfo fromLayer:layer].marginRightCode = spec.code;
                    break;
                case 2:
                    [NVUserInfo fromLayer:layer].marginBottomTarget = target.objectID;
                    [NVUserInfo fromLayer:layer].marginBottomCode = spec.code;
                    break;
                case 3:
                    [NVUserInfo fromLayer:layer].marginLeftTarget = target.objectID;
                    [NVUserInfo fromLayer:layer].marginLeftCode = spec.code;
                    break;
                default:
                    break;
            }
            if (target) {
//                [NVUserInfo fromLayer:layer].HoriType = [NSString stringWithFormat:@"%i",
//                [self relationOf:layer and:target]];
            }
        }

    }
    [self restoreActive];
    [self applySpec];
}

-(void)restoreActive {
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    for (NSView *view in self.collectionView.subviews) {
        if ([view isKindOfClass:[NVHoriCollectionItemView class]]) {
            NVHoriCollectionItemView *item = ((NVHoriCollectionItemView *) view);
            if ([item.spec.code isEqual:selectedSpecs[0]] || [item.spec.code isEqual:selectedSpecs[1]] || [item.spec.code isEqual:selectedSpecs[2]] || [item.spec.code isEqual:selectedSpecs[3]]) {
                [indexPaths addObject:item.indexPath];
            }
        }
    }
    [self.collectionView.toggleDelegate setActives:indexPaths];
}

-(void)applySpec{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    if(target == nil || layer == nil) {
        return;
    }
    
    if ([self relationOf:layer and:target]) {
        [self applyInnerTop];
        [self applyInnerRight];
        [self applyInnerBottom];
        [self applyInnerLeft];
    } else {
        [self applyOuterLeft];
        [self applyOuterRight];
        [self applyOuterTop];
        [self applyOuterBottom];
        
    }



}

-(void)applyInnerLeft{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[3]];
    if (spec.code == nil) return;
    layer.frame.x = target.frame.x + spec.ios;
}

-(void)applyInnerTop{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[0]];
    if (spec.code == nil) return;
    layer.frame.y = target.frame.y + spec.ios;
}
-(void)applyInnerRight{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[1]];
    NVHoriSpec leftSpec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[3]];
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
-(void)applyInnerBottom{
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[2]];
    NVHoriSpec topSpec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[0]];
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

-(int)relationOf:(MSLayer*)layer and:(MSLayer*) target {
    double x11 = target.frame.x;
    double x12 = target.frame.x + target.frame.width;
    double y11 = target.frame.y;
    double y12 = target.frame.y + target.frame.height;
    
    double x21 = layer.frame.x;
    double x22 = layer.frame.x + layer.frame.width;
    double y21 = layer.frame.y;
    double y22 = layer.frame.y + layer.frame.height;
    
    double size = MAX(MIN(x22,x12)-MAX(x21,x11),0) * MAX(MIN(y22,y12)-MAX(y21,y11),0);
    
    if (size == 0) {
        return 0;
    }
    double p = size / (layer.frame.width * layer.frame.height);
    if (p > 0.95) {
        return 1;
    }
    if (p > 0.1) {
        [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:@"图层不完全重合，智能判断为内边距模式"];
        return 1;
    } else {
        [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:@"图层不完全重合，智能判断为外边距模式"];
        return 0;
    }
    
}

-(void)applyOuterLeft {
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[3]];
    if (spec.code == nil) return;
    layer.frame.x = (target.frame.x + target.frame.width) + spec.ios;
}

-(void)applyOuterRight {
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[1]];
    NVHoriSpec leftSpec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[3]];
    if (spec.code == nil) return;
    if (leftSpec.code) {
        return;
    }
    layer.frame.x = (target.frame.x - layer.frame.width) - spec.ios;
}

-(void)applyOuterTop {
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[2]];
    if (spec.code == nil) return;
    layer.frame.y = (target.frame.y + target.frame.height) + spec.ios;
    

}

-(void)applyOuterBottom {
    MSLayer * target = [self.selections layerAtIndex:0];
    MSLayer * layer = [self.selections layerAtIndex:1];
    NVHoriSpec spec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[0]];
    if (spec.code == nil) return;
    NVHoriSpec topSpec = [self.collectionView.dataSource getSpecWithCode:selectedSpecs[2]];
    if (topSpec.code) {
        return;
    }
    layer.frame.y = (target.frame.y - layer.frame.height) - spec.ios;
}

//-(void)showAlert{
//    NSString *message = @"选中图层重合，请选择以下方式：";
//    NSAlert *alert = [NSAlert new];
//    [alert addButtonWithTitle:@"内边距"];
//    [alert addButtonWithTitle:@"外边距"];
//    [alert setMessageText:message];
//    [alert setAlertStyle:NSAlertStyleCritical];
//    [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSModalResponse returnCode) {
//        if(returnCode == NSAlertFirstButtonReturn){
//           //确定
//        }else if(returnCode == NSAlertSecondButtonReturn){
//           //取消
//        }
//    }];
//}

@end
