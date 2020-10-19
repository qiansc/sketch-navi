//
//  ColorCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorCollectionView.h"
#import "HexColor.h"

@implementation ColorCollectionView {
    NSMutableArray *arr;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    ColorCollectionView *view = [super initWithCoder:coder];
    view.source = [[NVColorSource alloc]init];
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
    ColorCollectionItem *item = [collectionView makeItemWithIdentifier:@"ColorCollectionItem" forIndexPath:indexPath];
    NVColorSpec spec = [self.source getSpecAt:indexPath];
    item.textFiled.stringValue = spec.specCode;
    item.view.wantsLayer = true;
    item.view.layer.backgroundColor  = NSColorFromRGBString(spec.hex).CGColor;
    // [NSColor greenColor].CGColor;
    NSLog(@"NAVIL ITEM %ld", (long)indexPath.item);
    return item;
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
        ColorSectionHeader *view =
        [self makeSupplementaryViewOfKind:kind withIdentifier: @"ColorSectionHeader" forIndexPath:indexPath];
        
        NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
        textField.stringValue = [self.source getDims][indexPath.section];
        textField.editable = NO;
        textField.bordered = NO;
        [view addSubview: textField];
        
//    } else if (kind == NSCollectionElementKindSectionFooter) {
    }
    return nil;
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NSMakeSize(50, 50);
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
