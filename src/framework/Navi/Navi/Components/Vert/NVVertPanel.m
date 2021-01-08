//
//  NVVertPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVVertPanel.h"
#import "NVVertSource.h"
#import "NVVertCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "MSDocument.h"
#import "NVUserData.h"

@implementation NVVertPanel {
    NVVertSpec se;
    int pos;  // 3  1   31
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pos = 0;
    [self.collectionView.toggleDelegate afterReload:^(void){
        // 一般是数据更新时 整体重绘 需要根据选中项重新选择
         [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox * box) {
        // 选择变化时 应用到selections 且改更新title
        if (box == nil) {
            [self updateTitle];
        }else{
            NVVertSpec spec = ((NVVertCollectionItemView *)box).spec;
            MSLayer *target = [self selectionTarget];
            MSLayer *layer = [self selectionLayer];
            if (target == nil || layer == nil) { // 没有目标图层
                [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"请选择 2个图层 或 1个有间距编码的图层 再进行操作！"]];
                [self restoreActive];
                return;
            }
 
            if (![spec.code isEqual:se.code]) {
                pos = 0;
            }
            se = spec;
            [self nextPos];
            [self applySpecToSelections: se];
            [self updateTitle];
        }
    }];
    [self.modButton setTarget:self];
    [self.modButton setAction:@selector(modChange:)];
    [self updateTitle];
}

-(MSLayer*)selectionTarget {
    MSLayer *firstLayer = [(MSLayerArray *)self.selections layerAtIndex:0];
    MSLayer *secondLayer = [(MSLayerArray *)self.selections layerAtIndex:1];
    if (secondLayer) {
        return firstLayer;
    }
    if (firstLayer == nil) return nil;
    NVUserInfo *info = [NVUserInfo fromLayer:firstLayer];
    if (info.marginTopTarget || info.marginBottomTarget) {
        MSDocument *document = [[NSDocumentController sharedDocumentController] currentDocument];
        return [document.documentData layerWithID:info.marginTopTarget];
    } else {
        return nil;
    }
}

-(MSLayer*)selectionLayer {
    MSLayer *firstLayer = [(MSLayerArray *)self.selections layerAtIndex:0];
    MSLayer *secondLayer = [(MSLayerArray *)self.selections layerAtIndex:1];
    if (secondLayer) {
        return secondLayer;
    }
    if (firstLayer == nil) return nil;
    NVUserInfo *info = [NVUserInfo fromLayer:firstLayer];
    if (info.marginTopTarget || info.marginBottomTarget) {
        return firstLayer;
    }
    return nil;
}

-(void)modChange:(NSSegmentedControl*) button{
    MSLayer *target = [self selectionTarget];
    MSLayer *layer = [self selectionLayer];
    if (target == nil || layer == nil){
        [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"请选择 2个图层 或 1个有间距编码的图层 再进行操作！"]];
        [self updateTitle];
        return;
    }
    if (se.code == nil) {
        // 无编码时候不可点
        [self.modButton setSelected:NO  forSegment:0];
        [self.modButton setSelected:NO  forSegment:1];
        return;
    }
    if (layer && [[NVUserInfo fromLayer:layer].marginType isNotEqualTo:@"1"]) {
        // marginType不为内边距模式
        if ([button isSelectedForSegment:0] && [button isSelectedForSegment:1]) {
            if (pos == 3)
                [self.modButton setSelected:NO  forSegment:0];
            else
                [self.modButton setSelected:NO  forSegment:1];
        }
    }
    if ([button isSelectedForSegment:0] && [button isSelectedForSegment:1]) {
        pos = 31;
    } else if ([button isSelectedForSegment:0])
        pos = 3;
    else if ([button isSelectedForSegment:1])
        pos = 1;
    else
        pos = 0;
    [self applySpecToSelections: se];
    [self updateTitle];
}

-(void)updateTitle{
    switch (pos) {
        case 3:
            [self.modButton setSelected:YES forSegment:0];
            [self.modButton setSelected:NO  forSegment:1];
            break;
        case 1:
            [self.modButton setSelected:NO  forSegment:0];
            [self.modButton setSelected:YES forSegment:1];
            break;
        case 31:
            [self.modButton setSelected:YES forSegment:0];
            [self.modButton setSelected:YES forSegment:1];
            break;
        default:
            [self.modButton setSelected:NO  forSegment:0];
            [self.modButton setSelected:NO  forSegment:1];
            break;
    }
    self.headerView.controller.infoButton.title = se.code ? se.code : nil;
}

-(NSObject<NVSource> *)generatePanelSource{
    // collectionView.source 直接就是 panelSource给外界
    return self.collectionView.dataSource;
}

- (void)selectionChange:(MSLayerArray *) layers {
    self.selections = layers;
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    se.code = nil;
    pos = 0;
    MSLayer *layer = [self selectionLayer];
    if (layer) {
        NSString *marginTopCode =[NVUserInfo fromLayer:layer].marginTopCode;
        NSString *marginBottomCode =[NVUserInfo fromLayer:layer].marginBottomCode;
        // NSLog(@"### data:%@", [NVUserInfo fromLayer:layer].data);
        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVVertCollectionItemView *item = ((NVVertCollectionItemView *) view);
                if ([item.spec.code isEqual:marginTopCode] || [item.spec.code isEqual:marginBottomCode]) {
                    [indexPaths addObject:item.indexPath];
                        se.code = item.spec.code;
                }
                if (marginTopCode && marginBottomCode) {
                    pos = 31;
                } else if (marginTopCode)
                    pos = 3;
                else if (marginBottomCode)
                    pos = 1;

            }
        }
    }
    [self.collectionView.toggleDelegate clearActive];
    // [self applySpec];
    if (indexPaths.count > 0) {
        if (indexPaths.count == 1) {
            [self updateTitle];
        }
        [self.collectionView.toggleDelegate setActives:indexPaths];
    } else {
        [self updateTitle];
    }

}
-(void)nextPos{
    MSLayer *layer = [self selectionLayer];
    switch (pos) {
        case 3:
            pos = 1;
            break;
        case 1:
            pos = 31;
            if (layer && [[NVUserInfo fromLayer:layer].marginType isNotEqualTo:@"1"]) {
                pos = 0;
                se.code = nil;
                [self.collectionView.toggleDelegate clearActive];
            }
            break;
        case 31:
            pos = 0;
            se.code = nil;
            [self.collectionView.toggleDelegate clearActive];
            break;
        default:
            pos = 3;
            break;
    }
}
/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVVertSpec) spec {
    MSLayer *target = [self selectionTarget];
    MSLayer *layer = [self selectionLayer];
    if (target && layer) {
        // if ([NVLayer isShape:layer]) {
            NVUserInfo *info = [NVUserInfo fromLayer:layer];
            switch (pos) {
                case 3:
                    info.marginTopCode = spec.code;
                    info.marginTopTarget = target.objectID;
                    info.marginBottomCode = nil;
                    break;
                case 1:
                    info.marginTopCode = nil;
                    info.marginBottomCode = spec.code;
                    info.marginBottomTarget = target.objectID;
                    break;
                case 31:
                    info.marginTopCode = spec.code;
                    info.marginBottomCode = spec.code;
                    info.marginTopTarget = target.objectID;
                    info.marginBottomTarget = target.objectID;
                    break;
                default:
                    info.marginTopCode = nil;
                    info.marginBottomCode = nil;
                    break;
            }
            if (target) {
                info.marginType = [NSString stringWithFormat:@"%d",
                [self relationOf:layer and:target]];
            }
        // }
        [self applySpec];
    }
}

-(void)restoreActive {
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    for (NSView *view in self.collectionView.subviews) {
        if ([view isKindOfClass:[NVVertCollectionItemView class]]) {
            NVVertCollectionItemView *item = ((NVVertCollectionItemView *) view);
            if ([item.spec.code isEqual:se.code]) {
                [indexPaths addObject:item.indexPath];
            }
        }
    }
    [self.collectionView.toggleDelegate setActives:indexPaths];
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


-(void)applySpec{
    MSLayer *target = [self selectionTarget];
    MSLayer *layer = [self selectionLayer];
    if (!layer) return;
    if (pos != 31 && layer != nil && [NVUserInfo fromLayer:layer].originHeight) {
        // 恢复原始宽度
        layer.frame.height = [NVUserInfo fromLayer:layer].originHeight;
    }
    if(target == nil) return;

    if ([self relationOf:layer and:target]) {
        [self applyInnerBottom];
        [self applyInnerTop];
    } else {
        [self applyOuterTop];
        [self applyOuterBottom];

    }

}
-(void)applyInnerTop{
    if (se.code == nil) return;
    if (pos == 3 || pos == 31) {
        MSLayer *target = [self selectionTarget];
        MSLayer *layer = [self selectionLayer];
        layer.frame.y = target.frame.y + [self dev:se];
    }
}


-(void)applyInnerBottom{
    if (se.code == nil) return;
    MSLayer *target = [self selectionTarget];
    MSLayer *layer = [self selectionLayer];
    if (pos == 31) {
        if ([NVUserInfo fromLayer:layer].gridScaleCode) {
            [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"存在栅格高度/比例编码 %@ ，请先移除！", [NVUserInfo fromLayer:layer].gridWidthCode]];
            return;
        }
        [NVUserInfo fromLayer:layer].originHeight = layer.frame.height;
        layer.frame.height = target.frame.height - [self dev:se] - [self dev:se];
    }
    if (pos == 1 || pos == 31) {
        layer.frame.y = target.frame.y + target.frame.height - layer.frame.height - [self dev:se];
    }
}


-(void)applyOuterTop {
    if (se.code == nil) return;
    if (pos == 3) {
        MSLayer *target = [self selectionTarget];
        MSLayer *layer = [self selectionLayer];
        layer.frame.y = (target.frame.y + target.frame.height) + [self dev:se];
    }
}

-(void)applyOuterBottom {
    if (se.code == nil) return;
    if (pos == 1) {
        MSLayer *target = [self selectionTarget];
        MSLayer *layer = [self selectionLayer];
        layer.frame.y = (target.frame.y - layer.frame.height) - [self dev:se];
    }
}

-(void)onPaste:(NSArray<MSLayer *> *)layers {
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    for(MSLayer *layer in layers) {
        NSString *oldKey = [NVUserInfo fromLayer:layer].objectID;
        if ([oldKey isNotEqualTo:layer.objectID]) {
            [mapper setValue:layer.objectID forKey:oldKey];
        }
    }
    for(MSLayer *layer in layers) {
        NVUserInfo *info = [NVUserInfo fromLayer:layer];
        if (info.marginTopTarget && mapper[info.marginTopTarget])
            info.marginTopTarget =  mapper[info.marginTopTarget];
        if (info.marginBottomTarget && mapper[info.marginBottomTarget])
            info.marginBottomTarget =  mapper[info.marginBottomTarget];
    }
}

-(double)dev:(NVVertSpec) spec{
    NSDictionary *data = [NVUserData userData];
    if ([data[@"unit"] isEqual:@"pt"]) {
        return spec.ios;
    } else if ([data[@"unit"] isEqual:@"dp"]) {
        return spec.android;
    } else {
        return spec.h5;
    }
}

@end
