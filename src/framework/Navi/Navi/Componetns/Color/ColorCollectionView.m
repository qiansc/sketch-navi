//
//  ColorCollectionView.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorCollectionView.h"
#import "ColorCollection.h"

@implementation ColorCollectionView

-(void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    self.delegate = self;
    self.dataSource = self;
    arr = [[NSMutableArray alloc] init];
    dict = [NSMutableDictionary new];
    for (int num = 0; num < 5; num++) {
        [arr addObject:[NSString stringWithFormat:@"%@%d",@"hello",num]];
    }
    NSLog(@"NAVIL ColorCollectionView1 %@ %f, %f", self.superview, self.frame.size.height, self.superview.frame.size.height);
    
//    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
//    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.superview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
//    NSCollectionView *view = self;
//    NSArray<NSLayoutConstraint *> * c = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|[view]|" options:0 metrics:nil views:
//                                             [NSDictionary dictionaryWithObject:view forKey:@"view"]];
//
////    [self removeConstraints:self.constraints];
//    [self.superview addConstraints:c];
    
     self.wantsLayer = true;
     self.layer.backgroundColor  = [NSColor yellowColor].CGColor;
    // [self reloadData];
}



-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"NAVIL  === %@", indexPath);
    ColorCollectionItem *item = [collectionView makeItemWithIdentifier:@"ColorCollectionItem" forIndexPath:indexPath];
    NSLog(@"NAVIL %@ %@", item, indexPath);
    item.textFiled.stringValue = @"HELLO!";
    item.view.wantsLayer = true;
    item.view.layer.backgroundColor  = [NSColor greenColor].CGColor;
    NSLog(@"NAVIL ITEMMMMM");
    NSLog(@"NAVIL ColorCollectionView2 %f, %f", self.frame.size.height, self.superview.frame.size.height);
    return item;
}
//
-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}

-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
    // return [arr count];
}

-(NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView{
    return 3;
}

- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind == NSCollectionElementKindSectionHeader) {
        ColorSectionHeader *oldview = dict[[NSString stringWithFormat:@"Header-%ld" , (long)indexPath.section]];

        if (oldview != nil) {
            // NSLog(@"REMOVE>%@", oldview);
            [oldview removeFromSuperview];
        }
        ColorSectionHeader *view = [self makeSupplementaryViewOfKind:kind withIdentifier: @"ColorSectionHeader" forIndexPath:indexPath];
        view.wantsLayer = true;
        view.layer.backgroundColor = [NSColor blueColor].CGColor;
        // view.titleTextField.stringValue = @"Header";
        // [view.button setTarget:self];
        // [view.button setAction:@selector(buttonClick:)];
        [dict setObject:view forKey:[ NSString stringWithFormat:@"Header-%ld" , (long)indexPath.section]];
    } else if (kind == NSCollectionElementKindSectionFooter) {
        
        NSLog(@"NAVIL ColorCollectionView3 %f, %f", self.frame.size.height, self.superview.frame.size.height);
    }
    return nil;
}

-(void)buttonClick:(NSButton*) sender {
    [arr addObject:[NSString stringWithFormat:@"%@",@"hello MORE"]];
    [self reloadData];
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return NSMakeSize(50, 50);
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return NSMakeSize(0, 60);
    
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return NSMakeSize(0, 60);
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSLog(@"NAVIL ColorCollectionViewRR %f, %f", self.frame.size.height, self.superview.frame.size.height);
}



@end
