//
//  NVShadowCollectionView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/6.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVShadowCollectionView.h"
#import "NVCollectionDelegate.h"
#import "NVShadowCollectionItemView.h"
#import "NVSectionHeader.h"
#import "NVBundle.h"

@implementation NVShadowCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = [[NVShadowSource alloc] init];
    [self.dataSource onUpdated: ^void() {
        [self.toggleDelegate clearActive];
        [self reloadData];
    }];
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVShadowCollectionItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-1"];
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVShadowCollectionItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-0"];
}

#pragma mark NSCollectionViewDelegate

- (void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    NVShadowSpec spec = [self.dataSource getSpecAt: indexPath];
    NVShadowCollectionItemView *view = item.view;
    // if (view.indexPath == nil) {
    [view reset];
    view.spec = spec;
    view.indexPath = indexPath;
    // }
    [view onMouseDown: ^void(NSEvent* event, NSBox* box) {
        [self.toggleDelegate clearActive];
        [self.toggleDelegate setActive:((NVToggleBox *) box).indexPath];
    }];
}

- (void)collectionView:(NSCollectionView *)collectionView willDisplaySupplementaryView:(NSView *)view forElementKind:(NSCollectionViewSupplementaryElementKind)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (elementKind == NSCollectionElementKindSectionHeader && [[self.dataSource getDims] count] > 1) {
        [(NVSectionHeader *)view setTitle: [self.dataSource getDims][indexPath.section]];
    }
}

#pragma mark NSCollectionViewDelegateFlowLayout

- (NSSize)collectionView:(NSController *) collectionView layout:(NSCollectionViewLayout *) collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *) indexPath {
    return NSMakeSize(215, 48);
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([[self.dataSource getDims] count] < 2)
        return NSMakeSize(0, 10);
    else
        return NSMakeSize(0, 26);

}

@end
