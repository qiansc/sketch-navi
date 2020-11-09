//
//  NVMaskCollectionView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/11/5.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMaskCollectionView.h"
#import "NVCollectionDelegate.h"
#import "NVMaskCollectionItemView.h"
#import "NVSectionHeader.h"
#import "NVBundle.h"

@implementation NVMaskCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = [[NVMaskSource alloc] init];
    [self.dataSource onUpdated: ^void() {
        [self.toggleDelegate clearActive];
        [self reloadData];
    }];
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVMaskSemanticItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-1"];
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVMaskCollectionItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-0"];
}

#pragma mark NSCollectionViewDelegate

- (void)collectionView:(NSController *) collectionView willDisplayItem:(nonnull NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NVMaskSpec spec = [self.dataSource getSpecAt:indexPath];
    NVMaskCollectionItemView *view = item.view;
    if (view.indexPath == nil) {
        view.spec = spec;
        view.indexPath = indexPath;
    }
    [view onMouseDown: ^void(NSEvent* event, NSBox* box) {
        [self.toggleDelegate clearActive];
        [self.toggleDelegate setActive:((NVToggleBox *) box).indexPath];
    }];
}

- (void)collectionView:(NSCollectionView *) collectionView willDisplaySupplementaryView:(nonnull NSView *) view forElementKind:(nonnull NSCollectionViewSupplementaryElementKind) kind atIndexPath:(nonnull NSIndexPath *) indexPath {
    if (kind == NSCollectionElementKindSectionHeader && [[self.dataSource getDims] count] > 1) {
        [(NVSectionHeader*)view setTitle:[self.dataSource getDims][indexPath.section]];
    }
}

#pragma mark NSCollectionViewDelegateFlowLayout

- (NSSize)collectionView:(NSController *) collectionView layout:(NSCollectionViewLayout *) collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *) indexPath {
    return NSMakeSize(218, 48);
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([[self.dataSource getDims] count] < 2)
        return NSMakeSize(0, 10);
    else
        return [super collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section]; 
    
}

@end
