//
//  NVMarginCollectionView.m
//  Navi
//
//  Created by QIANSC on 2020/11/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVMarginCollectionView.h"
#import "NVCollectionDelegate.h"
#import "NVMarginCollectionItemView.h"
#import "NVSectionHeader.h"
#import "HexColor.h"
#import "NVBundle.h"

@implementation NVMarginCollectionView {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dataSource = [[NVMarginSource alloc]init];
    [self.dataSource onUpdated: ^void(){
        [self.toggleDelegate clearActive];
        [self reloadData];
    }];
    
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVMarginSemanticItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-1"];
    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVMarginCollectionItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item-0"];
    
}

#pragma mark NSCollectionViewDelegate

-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NVMarginSpec spec = [self.dataSource getSpecAt:indexPath];
    NVMarginCollectionItemView *view = item.view;
    // if (view.indexPath == nil) {
    [view reset];
    view.spec = spec;
    view.indexPath = indexPath;
    // }
    [view onMouseDown:^void(NSEvent* event, NSBox* box) {
        [self.toggleDelegate clearActive];
        [self.toggleDelegate setActive:((NVToggleBox *)box).indexPath];
    }];
}

- (void)collectionView:(NSCollectionView *)collectionView willDisplaySupplementaryView:(NSView *)view forElementKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *) indexPath{
    // if (kind == NSCollectionElementKindSectionHeader && [[self.dataSource getDims] count] > 1) {
        [(NVSectionHeader*)view setTitle:[self.dataSource getDims][indexPath.section]];
    // }
}


#pragma mark NSCollectionViewDelegateFlowLayout

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.semanticMode) {
        self.isLiveResize = YES;
        return NSMakeSize([self autoItemWithBetween:218 and:218 * 2], 31);
    } else {
        self.isLiveResize = NO;
        return NSMakeSize(31, 31);
    }
    
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if ([[self.dataSource getDims] count] < 2)
//        return NSMakeSize(0, 10);
//    else
        return [super collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    
}

@end
