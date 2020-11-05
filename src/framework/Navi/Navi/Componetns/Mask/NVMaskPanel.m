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

- (void)selectionChange:(MSLayerArray *)layers {
    
}

- (void)applySpecToSelections:(NVMaskSpec) spec {
    
}


@end
