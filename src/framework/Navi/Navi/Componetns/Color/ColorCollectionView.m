//
//  ColorCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorCollectionView.h"

static NSString *headIdentifier = @"ColorSectionHeader";

@implementation ColorCollectionView

-(void)viewDidMoveToWindow {
//    self.delegate = self;
    self.dataSource = self;
     arr = [[NSMutableArray alloc] init];
    // dict = [NSMutableDictionary new];
    for (int num = 0; num < 5; num++) {
        [arr addObject:[NSString stringWithFormat:@"%@%d",@"hello",num]];
    }
}

-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"NAVIL  === %@", indexPath);
    ColorCollectionItem *item = [collectionView makeItemWithIdentifier:@"ColorCollectionItem" forIndexPath:indexPath];
    NSLog(@"NAVIL %@ %@", item, indexPath);
    item.textFiled.stringValue = @"HELLO!";
    item.view.wantsLayer = true;
    item.view.layer.backgroundColor  = [NSColor greenColor].CGColor;
    return item;
}
//
-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
    // return [arr count];
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 2;
}

//- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    if (kind == NSCollectionElementKindSectionHeader) {
//        ColorSectionHeader *oldview = dict[[NSString stringWithFormat:@"Header-%ld" , (long)indexPath.section]];
//
//        if (oldview != nil) {
//            // NSLog(@"REMOVE>%@", oldview);
//            [oldview removeFromSuperview];
//        }
//        ColorSectionHeader *view = [self makeSupplementaryViewOfKind:kind withIdentifier: headIdentifier forIndexPath:indexPath];
//        view.wantsLayer = true;
//        view.layer.backgroundColor = [NSColor greenColor].CGColor;
//        // view.titleTextField.stringValue = @"Header";
//        // [view.button setTarget:self];
//        // [view.button setAction:@selector(buttonClick:)];
//        [dict setObject:view forKey:[ NSString stringWithFormat:@"Header-%ld" , (long)indexPath.section]];
//    } else if (kind == NSCollectionElementKindSectionFooter) {}
//    return nil;
//}

-(void)buttonClick:(NSButton*) sender {
    [arr addObject:[NSString stringWithFormat:@"%@",@"hello MORE"]];
    [self reloadData];
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NSMakeSize(100, 100);
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return NSMakeSize(0, 60);
    
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return NSMakeSize(0, 60);
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
