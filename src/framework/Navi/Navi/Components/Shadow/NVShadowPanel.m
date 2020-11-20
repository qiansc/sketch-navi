//
//  NVShadowPanel.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVShadowPanel.h"
#import "NVShadowSource.h"
#import "NVShadowCollectionItemView.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "NVUserInfo.h"
#import "NVLayer.h"
#import "HexColor.h"
#import "MSColor.h"

@interface NVShadowPanel ()

@end

@implementation NVShadowPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.toggleDelegate afterReload:^(void) {
        [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox *box) {
        if (box == nil) {
            [self updateTitle:nil];
        } else {
            [self applySpecToSelections: ((NVShadowCollectionItemView *) box).spec];
            [self updateTitle: ((NVShadowCollectionItemView *) box).spec.code];
        }
    }];
    if (self.selections == nil) {
        self.selections = @[];
    }
    [self updateTitle: nil];
}

- (void)updateTitle:(NSString *) title {
    self.headerView.controller.infoButton.title = title;
}

- (NSObject<NVSource> *)generatePanelSource {
    return self.collectionView.dataSource;
}

- (void)selectionChange:(NSArray<MSLayer *> *)layers {
    self.selections = layers;
    NSMutableArray<NSIndexPath*>* indexPaths = [NSMutableArray new];
    NSString *title = nil;
    for (MSLayer *layer in layers) {
        if (![NVLayer isShape:layer]) continue;
        NSString *shadowCode =[NVUserInfo fromLayer:layer].shadowCode;
        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVShadowCollectionItemView *item = ((NVShadowCollectionItemView *) view);
                if ([item.spec.code isEqual:shadowCode]) {
                    [indexPaths addObject:item.indexPath];
//                    [self applyShadow:item.spec toLayer:layer];
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

- (void)applySpecToSelections:(NVShadowSpec) spec {
    if (self.selections) {
        for(MSLayer *layer in self.selections) {
            if (![NVLayer isShape:layer]) continue;
            [NVUserInfo fromLayer:layer].shadowCode = spec.code;
            [self applyShadow:spec toLayer:layer];
        }
    }
}

-(void)applyShadow:(NVShadowSpec) spec toLayer:(MSLayer*) layer{
    if (layer.style.shadows.count == 0) {
//        [layer.style.shadows addNewStylePart];
        // 0- fill, 1- stroke, 2-shadow
        [layer.style addStylePartOfType: 2];
    }
    for (MSStyleShadow *shadow in layer.style.shadows) {
        shadow.offsetX = spec.x;
        shadow.offsetY = spec.y;
        shadow.spread = spec.spread;
        shadow.blurRadius = spec.size;
        NSColor *newColor = NSColorFromRGBString(spec.color);
        shadow.color = [MSColor colorWithRed:newColor.redComponent green:newColor.greenComponent blue:newColor.blueComponent alpha:spec.opacity];
    }
}

@end
