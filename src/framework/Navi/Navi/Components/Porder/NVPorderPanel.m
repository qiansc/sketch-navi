//
//  NVPorderPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import "MSDocument.h"
#import "NVPorderPanel.h"
#import "NVPorderSource.h"
#import "NVPorderCollectionItemView.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "NVUserData.h"
#import "MSShapeEventHandler.h"
#import "MSCurvePoint.h"

@implementation NVPorderPanel 

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
            [self applySpecToSelections: ((NVPorderCollectionItemView *)box).spec];
            [self updateTitle: ((NVPorderCollectionItemView *)box).spec.code];
        }
    }];
    if (self.selections == nil) self.selections = @[];
    [self updateTitle:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkPoint) userInfo:nil repeats:YES];
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
//    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
//    NSString *title = nil;
//    for (MSLayer *layer in layers) {
//        NSLog(@"$$$ hahahah is %@", layer.points[0]);
//        if (![NVLayer isRectangleShape:layer]) continue;
//        NSString *cornerRadiusCode =[NVUserInfo fromLayer:layer].cornerRadiusCode;
//        for (NSView *view in self.collectionView.subviews) {
//            if ([view isKindOfClass:[NVToggleBox class]]) {
//                NVPorderCollectionItemView *item = ((NVPorderCollectionItemView *) view);
//                if ([item.spec.code isEqual:cornerRadiusCode]) {
//                    [indexPaths addObject:item.indexPath];
//                    [self applyCornerRadius:item.spec toLayer:layer];
//                    title = item.spec.code;
//                }
//            }
//        }
//    }
    self.points = [NSArray new];
    [self.collectionView.toggleDelegate clearActive];
//    if (indexPaths.count > 0) {
//        [self.collectionView.toggleDelegate setActives:indexPaths];
//        if (indexPaths.count == 1) {
//            [self updateTitle:title];
//        }
//    }

}
/* 应用spec到图层上 */
-(void)applySpecToSelections:(NVPorderSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if (![NVLayer isRectangleShape:layer]) continue;
            // [NVUserInfo fromLayer:layer].cornerRadiusCode = spec.code;
            [self applyCornerRadius:spec toLayer:layer];
        }
    }
}

-(void)applyCornerRadius:(NVPorderSpec) spec toLayer:(MSLayer*) layer{
    NSString *radiusString = [self dev:spec];
    float num = [radiusString doubleValue];
    long index = 0;
    MSDocument *document = [[NSDocumentController sharedDocumentController] currentDocument];
    NSMutableDictionary *dict = [[NVUserInfo fromLayer:layer].cornerRadiusCodes mutableCopy];
    if (document.currentHandler && [[document.currentHandler className] isEqualToString:@"MSShapeEventHandler"]) {
        
        MSShapeEventHandler *hanlder = document.currentHandler;
        index = hanlder.pathController.selectedObjects.count;
        for(MSCurvePoint *point in hanlder.pathController.selectedObjects) {
                    if (num) {
                        if (num == -1) {
                            point.cornerRadius = MAX(layer.frame.width, layer.frame.height)/2;
                        } else {
                            point.cornerRadius = num;
                        }
                    } else {
                        point.cornerRadius = 0;
                    }
            NSString *key = [NSString stringWithFormat:@"%d,%d", (int)point.point.x, (int)point.point.y];
            if ([dict[key] isEqual:spec.code]) {
                [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"取消点边角"]];
                [dict setValue:nil forKey: key];
                [self.collectionView.toggleDelegate clearActive];
            } else {
                [dict setValue:spec.code forKey: key];
            }
        }
    }

    if (index == 0) {
        [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"请选择至少一个顶点再进行操作"]];
        [self.collectionView.toggleDelegate clearActive];
    }
    [NVUserInfo fromLayer:layer].cornerRadiusCodes = dict;
}

-(NSString*)dev:(NVPorderSpec) spec{
    NSDictionary *data = [NVUserData userData];
    if ([data[@"unit"] isEqual:@"pt"]) {
        return spec.ios;
    } else if ([data[@"unit"] isEqual:@"dp"]) {
        return spec.android;
    } else {
        return spec.h5;
    }
}

-(void)checkPoint {
    MSDocument *doc = [[NSDocumentController sharedDocumentController] currentDocument];

    if (self.selections && doc && doc.currentHandler && [[doc.currentHandler className] isEqualToString:@"MSShapeEventHandler"]) {
        MSShapeEventHandler *hanlder = doc.currentHandler;
        if (hanlder && hanlder.pathController && hanlder.pathController.selectedObjects){
            NSArray<MSCurvePoint*>* arr = hanlder.pathController.selectedObjects;
            // arr isEqualToArray
            if ([arr isEqualToArray:self.points]) {
                return;
            }
            self.points = arr;
            [self pointChanged];
            return;
        }
    }
    if (self.points.count) {
        self.points = [NSArray new];
        [self pointChanged];
    }
}

-(void)pointChanged {
        NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
        NSString *title = nil;
    MSLayer *layer;
    for(MSLayer *l in self.selections) {
        layer = l;
    }
    NSDictionary *codes = [NVUserInfo fromLayer:layer].cornerRadiusCodes;
    
    for (MSCurvePoint *point in self.points) {
        NSString *code = codes[[NSString stringWithFormat:@"%d,%d", (int)point.point.x, (int)point.point.y]];

        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVPorderCollectionItemView *item = ((NVPorderCollectionItemView *) view);
                if ([item.spec.code isEqual:code]) {
                    [indexPaths addObject:item.indexPath];
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

@end
