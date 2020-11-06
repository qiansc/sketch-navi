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
    self.headerView.infoButton.title = title;
}

- (NSObject<NVSource> *)generatePanelSource {
    return self.collectionView.dataSource;
}

- (void)selectionChange:(NSArray<MSLayer *> *)layers {}

- (void)applySpecToSelections:(NVShadowSpec) spec {}

@end
