//
//  NVLineCollectionView.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineCollectionView.h"
#import "NVCollectionDelegate.h"
#import "NVLineCollectionItemView.h"

@implementation NVLineCollectionView {
    NSMutableArray *arr;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NVLineCollectionView *view = [super initWithCoder:coder];
    view.source = [[NVLineSource alloc]init];
    [view.source onUpdated: ^void(){
        [self.toggleDelegate clearActive];
        [self reloadData];
    }];

    self.toggleDelegate = [NVCollectionDelegate new];
    self.toggleDelegate.collectionView = view;
    return view;
}

- (void)viewDidMoveToWindow {
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

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NVLineSpec spec = [self.source getSpecAt:indexPath];
    NSCollectionViewItem *cell = [collectionView makeItemWithIdentifier:@"NVLineCollectionItem" forIndexPath:indexPath];
    NVLineCollectionItemView *item = cell.view;
    item.spec = spec;
    item.indexPath = indexPath;
    [item onMouseDown:^void(NSEvent* event, NSBox* box) {
        [self.toggleDelegate clearActive];
        [self.toggleDelegate setActive:((NVToggleBox *)box).indexPath];
    }];
    return cell;
}

//
-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.source getSpecsIn:section] count];
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return [[self.source getDims] count];
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == NSCollectionElementKindSectionHeader) {
        NVLineSectionHeader *view =
        [self makeSupplementaryViewOfKind:kind withIdentifier: @"NVColorSectionHeader" forIndexPath:indexPath];
        [view setTitle:[self.source getDims][indexPath.section]];
    }
    return nil;
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NSMakeSize(206, 48);
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
