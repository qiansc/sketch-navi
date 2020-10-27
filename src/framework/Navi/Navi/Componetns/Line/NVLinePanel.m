//
//  NVLinePanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLinePanel.h"
#import "NVCollectionController.h"
#import "NVLineSource.h"
#import "NVLineCollectionItemView.h"
#import "NVLayer.h"
#import "MSLayerArray.h"

@interface NVLinePanel ()

@end

@implementation NVLinePanel

- (void)viewDidLoad {
    [super viewDidLoad];
    NVCollectionController *collectionController = [[NVCollectionController alloc] init];
    [collectionController setCollectionView:self.collectionView];

    collectionController.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };

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
    return self.collectionView.source;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers{
    // 保存当前被选中的layers
    self.selections = layers;
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for (MSLayer *layer in layers) {
        NSArray<NSString*>* lineCodes = [NVLayer getLineWeightCodeIn:layer];
        for (NSString *lineCode in lineCodes) {
            for (NSView *view in self.collectionView.subviews) {
                if ([view isKindOfClass:[NVLineCollectionItemView class]]) {
                    NVLineCollectionItemView *item = ((NVLineCollectionItemView *) view);
                    if ([item.spec.specCode isEqual:lineCode]) {
                        [indexPaths addObject:item.indexPath];
                        [self applyLine:item.spec.weight toLayer:layer];
                        title = item.spec.specCode;
                    }
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
            if ([[layer className] isEqual:@"MSShapePathLayer"]) {
                for(NSInteger i = 0; i < [layer.style.borders count]; i++) {
                    [NVLayer set:layer lineWeightCode:spec.specCode at:i];
                }
            }
            [self applySpec:spec toLayer:layer];
        }
    }
}

- (void) applySpec:(NVLineSpec) spec toLayer:(MSLayer *) layer {
    [self applyLine:spec.weight toLayer:layer];
}

- (void)applyLine:(NSString *) lineWeight toLayer:(MSLayer *) layer {
    if (![[layer className] isEqual:@"MSShapePathLayer"]) {
        return;
    }
    for (MSStyleBorder *border in layer.style.borders) {
        border.thickness = [(NSNumber *)lineWeight doubleValue];
    }
}

- (int)height {
    int superHeight = [super height];
    return superHeight + 20;
}

@end
