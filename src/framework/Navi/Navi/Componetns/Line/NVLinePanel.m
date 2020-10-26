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
    NVCollectionController *collectionController = [[NVCollectionController alloc] init];
    [collectionController setCollectionView:self.collectionView];

    collectionController.afterResize = ^(float width, float height) {
        [self resetConstraint];
    };
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

}

- (void) applySpecToSelections:(NVLineSpec)spec {
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
}

- (int)height {
    int superHeight = [super height];
    return superHeight + 20;
}

@end
