//
//  NVTextCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVTextCollectionView.h"
#import "NVCollectionDelegate.h"
#import "NVTextCollectionItemView.h"
#import "NVSectionHeader.h"
#import "HexColor.h"
#import "NVBundle.h"

@implementation NVTextCollectionView {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = [[NVTextSource alloc]init];
    [self.dataSource onUpdated: ^void(){
        [self.toggleDelegate clearActive];
        [self reloadData];
    }];

    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVFontSemanticItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-1"];
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVFontCollectionItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-0"];
}

#pragma mark NSCollectionViewDelegate

-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NVTextSpec spec = [self.dataSource getSpecAt:indexPath];
    NVTextCollectionItemView *view = item.view;
    if (view.indexPath == nil) {
        view.spec = spec;
        view.indexPath = indexPath;
        [view addConstraint:[view.heightAnchor constraintEqualToConstant: spec.iosFontSize + 33]];
    }
    [view onMouseDown:^void(NSEvent* event, NSBox* box) {
         [self.toggleDelegate clearActive];
         [self.toggleDelegate setActive:((NVToggleBox *)box).indexPath];
    }];
}


- (void)collectionView:(NSCollectionView *)collectionView willDisplaySupplementaryView:(NSView *)view forElementKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *) indexPath{
    if (kind == NSCollectionElementKindSectionHeader) {
        [(NVSectionHeader*)view setTitle:[self.dataSource getDims][indexPath.section]];
    }
}

#pragma mark NSCollectionViewDelegateFlowLayout

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.semanticMode) {
        return NSMakeSize(215, 31);
    } else {
        NVTextSpec spec = [self.dataSource getSpecAt:indexPath];
        return NSMakeSize(215, spec.iosFontSize + 33);
    }

}

@end
