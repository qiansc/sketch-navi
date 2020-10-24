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

@interface NVLinePanel ()

@end

@implementation NVLinePanel

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"------line panel viewDidload---------");
    NVCollectionController *collectionController = [[NVCollectionController alloc] init];
    [collectionController setCollectionView:self.collectionView];
    
    collectionController.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };
    [self.collectionView.toggleDelegate onChange:^(NVToggleBox *box) {
        NSLog(@"-------toggle onChange-------");
        if (box == nil) {
            [self updateTitle:nil];
        } else {
//            [self applySpecToSelections:((NVColorCollectionItemView *) box).spec];
//            [self updateTitle:((NVcon))]
        }
    }];
    NSLog(@"------line panel viewDidload----after-----");
    // Do view setup here.
}

- (void)updateTitle:(NSString*) title{
    NSLog(@"-------updateTitle----");
    self.headerView.infoButton.title = title;
}

- (void)selectionChange:(NSArray<MSLayer*>*) layers{
    NSLog(@"-------selection change-------");
}

- (void) applySpecToSelections:(NVLineSpec)spec {
    NSLog(@"-----apply select-------");
    if (self.selections) {
        for (MSLayer *layer in self.selections) {
            [self applySpec:spec toLayer:layer];
        }
    }
}

- (void) applySpec:(NVLineSpec) spec toLayer:(MSLayer *) layer {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"lineCode"] = spec.specCode;
    layer.userInfo = dic;
    [self applyLine:spec.weight toLayer:layer];
}

- (void)applyLine:(NSString *) line toLayer:(MSLayer *) layer {
    NSLog(@"apply line to layer");
}

- (int)height {
    return 200;
}

@end
