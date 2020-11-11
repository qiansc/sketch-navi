//
//  NVMaskPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMaskPanel.h"
#import "NVMaskSource.h"
#import "NVMaskCollectionItemView.h"
#import "NVLayer.h"
#import "MSLayerArray.h"
#import "NVBundle.h"
#import "MSStyleFill.h"
#import "MSGradient.h"
#import "NVUserInfo.h"
#import "MSStyleFill.h"

@interface NVMaskPanel ()

@end

@implementation NVMaskPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView.toggleDelegate afterReload:^(void) {
        [self selectionChange:self.selections];
    }];

    [self.collectionView.toggleDelegate onChange:^(NVToggleBox *box) {
        if (box == nil) {
            [self updateTitle: nil];
        } else {
            [self applySpecToSelections: ((NVMaskCollectionItemView *) box).spec];
            [self updateTitle: ((NVMaskCollectionItemView *) box).spec.code];
        }
    }];
    if (self.selections == nil) {
        self.selections = @[];
    }
    [self updateTitle: nil];
}

- (void)updateTitle:(NSString *) title {
    self.headerView.infoButton.title = title;
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
        NSString *fillMaskCode =[NVUserInfo fromLayer:layer].fillMaskCode;
        for (NSView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[NVToggleBox class]]) {
                NVMaskCollectionItemView *item = ((NVMaskCollectionItemView *) view);
                if ([item.spec.code isEqual:fillMaskCode]) {
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

- (void)applySpecToSelections:(NVMaskSpec) spec {
    if (self.selections) {
        for (MSLayer *layer in self.selections) {
            if (![NVLayer isShape:layer]) continue;
            [NVUserInfo fromLayer:layer].fillMaskCode = spec.code;
            [self applyMask:spec toLayer:layer];
        }
    }
}

- (void)applyMask:(NVMaskSpec) spec toLayer:(MSLayer *)layer {
    // fillType 1代表线性渐变
    [layer.style removeAllStyleFills];
    MSGradient *gradient = [[[NVBundle SketchModelBundle] classNamed: @"MSGradient"] new];
    gradient.from = CGPointMake(spec.from.x, spec.from.y);
    gradient.to = CGPointMake(spec.to.x, spec.to.y);
    gradient.elipseLength = 0;
    NSMutableArray *stops = [NSMutableArray new];
    Class Stop = [[NVBundle SketchModelBundle] classNamed: @"MSGradientStop"];
    for (MaskStop *stop in spec.stops) {
        MSGradientStop *msgs = [Stop new];
        msgs.color = stop.color;
        msgs.position = stop.position;
        [stops addObject:msgs];
    }
    gradient.stops = stops;
    MSStyleFill *fill = [[[NVBundle SketchModelBundle] classNamed: @"MSStyleFill"] new];
    fill.gradient = gradient;
    fill.fillType = 1;
    [layer.style addStyleFill: fill];
}


@end
