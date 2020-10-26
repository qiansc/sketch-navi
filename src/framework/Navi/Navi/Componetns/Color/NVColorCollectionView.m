//
//  NVColorCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVColorCollectionView.h"
#import "NVCollectionDelegate.h"
#import "NVColorCollectionItemView.h"
#import "NVColorSemanticItemView.h"
#import "HexColor.h"

@implementation NVColorCollectionView {
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    NVColorCollectionView *view = [super initWithCoder:coder];
    view.source = [[NVColorSource alloc]init];
    [view.source onUpdated: ^void(){
        [self.toggleDelegate clearActive];
        [self reloadData];
//      [self deleteSections: [NSIndexSet indexSetWithIndex:0]];
    }];

    self.toggleDelegate = [NVCollectionDelegate new];
    self.toggleDelegate.collectionView = view;
    self.semanticMode = NO;
    return view;
}

-(void)viewDidMoveToWindow {
    self.delegate = self;
    self.dataSource = self;
    [super viewDidMoveToWindow];

}

- (void)viewDidMoveToSupervijjew {
    [super viewDidMoveToSuperview];
}



-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NVColorSpec spec = [self.source getSpecAt:indexPath];
    NSString * className= self.semanticMode ? @"NVColorSemanticItem" : @"NVColorCollectionItem";
    NSCollectionViewItem *cell = [collectionView makeItemWithIdentifier:className forIndexPath:indexPath];
    
    if (self.semanticMode) {
        NVColorSemanticItemView *item = cell.view;
        item.spec = spec;
        item.indexPath = indexPath;
        [item onMouseDown:^void(NSEvent* event, NSBox* box) {
            [self.toggleDelegate clearActive];
            [self.toggleDelegate setActive:((NVToggleBox *)box).indexPath];
        }];
    }else {
        NVColorCollectionItemView *item = cell.view;
        item.spec = spec;
        item.indexPath = indexPath;
        [item onMouseDown:^void(NSEvent* event, NSBox* box) {
            [self.toggleDelegate clearActive];
            [self.toggleDelegate setActive:((NVToggleBox *)box).indexPath];
        }];
    }
    // NSLog(@"NAVIL collectionView ITEM semanticMode %hhd", self.semanticMode);
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
    if (self.semanticMode) {
        return NSMakeSize(208, 31);
    } else {
        return NSMakeSize(31, 31);
    }
    
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
