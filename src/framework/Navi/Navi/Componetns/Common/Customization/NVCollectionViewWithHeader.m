//
//  NVCollectionViewWithHeader.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/3.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVCollectionViewWithHeader.h"

@implementation NVCollectionViewWithHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    [self registerClass:[NVSectionHeader class] forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:@"Header"];
}

#pragma mark NSCollectionViewDelegate

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)collectionView:(NSCollectionView *)collectionView didEndDisplayingSupplementaryView:(NSView *)view forElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark NSCollectionViewDelegateFlowLayout


- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return NSMakeSize(0, 26);

}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return NSMakeSize(0, 0);
}
@end
