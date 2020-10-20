//
//  NVColorCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorCollectionView.h"
#import "HexColor.h"

@implementation NVColorCollectionView {
    NSMutableArray *arr;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    NVColorCollectionView *view = [super initWithCoder:coder];
    view.source = [[NVColorSource alloc]init];
    [view.source onUpdated: ^void(){
        NSLog(@"NAVIL SHOWWWWW");
        [self reloadData];
    }];
    return view;
}

-(void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    self.delegate = self;
    self.dataSource = self;
    arr = [[NSMutableArray alloc] init];
    for (int num = 0; num < 5; num++) {
        [arr addObject:[NSString stringWithFormat:@"%@%d",@"hello",num]];
    }
}

- (void)viewDidMoveToSuperview {
    [super viewDidMoveToSuperview];
}



-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NVColorSpec spec = [self.source getSpecAt:indexPath];
    NVColorCollectionItem *cell = [collectionView makeItemWithIdentifier:@"NVColorCollectionItem" forIndexPath:indexPath];
    [cell initWithSpec:spec];
    return cell;
}

//
-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // NSLog(@"NAVIL numberOfItemsInSection %@", [self.source getDims]);
    return [[self.source getSpecsIn:section] count];
    // return [arr count];
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return [[self.source getDims] count];
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == NSCollectionElementKindSectionHeader) {
        NVColorSectionHeader *view =
        [self makeSupplementaryViewOfKind:kind withIdentifier: @"NVColorSectionHeader" forIndexPath:indexPath];
        [view setTitle:[self.source getDims][indexPath.section]];
    }
    return nil;
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NSMakeSize(31, 31);
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return NSMakeSize(0, 26);

}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return NSMakeSize(0, 0);
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
