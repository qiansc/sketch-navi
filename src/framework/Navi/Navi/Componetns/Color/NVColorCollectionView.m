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
#import "NVBundle.h"

@implementation NVColorCollectionView {
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    NVColorCollectionView *view = [super initWithCoder:coder];


    self.toggleDelegate = [NVCollectionDelegate new];
    self.toggleDelegate.collectionView = view;
    self.delegate = self;
    self.dataSource = [[NVColorSource alloc]init];
    [self.dataSource onUpdated: ^void(){
//            [self.toggleDelegate clearActive];
//            [self reloadData];
    }];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor greenColor].CGColor;
    NSLog(@"### NVColorCollectionView initWithCoder %@", self.dataSource);
    

    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVColorCollectionItem" bundle:[NVBundle bundlePath]] forItemWithIdentifier:@"Item"];
    
    [self registerClass:[NVColorSectionHeader class] forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:@"Header"];
    
    
//    [self registerNib:[[NSNib alloc] initWithNibNamed:@"NVHeader" bundle:[NVBundle bundlePath]] forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:@"Header"];
    
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"### NVColorCollectionView awakeFromNib %@", self.dataSource);
//    NSRect f = self.collectionView.frame;
//    self.collectionView.frame = NSMakeRect(f.origin.x, f.origin.y, f.size.width, f.size.height);
    
    
}

//-(void)viewDidMoveToWindow {
//    [super viewDidMoveToWindow];
//
//}
//
//- (void)viewDidMoveToSupervijjew {
//    [super viewDidMoveToSuperview];
//}
//
//



#pragma mark NSCollectionViewDelegate

-(void)collectionView:(NSCollectionView *)collectionView willDisplayItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    NVColorSpec spec = [self.dataSource getSpecAt:indexPath];
    NVColorCollectionItemView *view = item.view;
    if (view.indexPath == nil) {
        view.spec = spec;
        view.indexPath = indexPath;
    }
//    [view onMouseDown:^void(NSEvent* event, NSBox* box) {
//         [self.toggleDelegate clearActive];
//         [self.toggleDelegate setActive:((NVToggleBox *)box).indexPath];
//    }];
}

-(void)collectionView:(NSCollectionView *)collectionView didEndDisplayingItem:(NSCollectionViewItem *)item forRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
}


- (void)collectionView:(NSCollectionView *)collectionView willDisplaySupplementaryView:(NSView *)view forElementKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *) indexPath{
    if (kind == NSCollectionElementKindSectionHeader) {
        [(NVColorSectionHeader*)view setTitle:[self.dataSource getDims][indexPath.section]];
    }
}

- (void)collectionView:(NSCollectionView *)collectionView didEndDisplayingSupplementaryView:(NSView *)view forElementOfKind:(NSCollectionViewSupplementaryElementKind)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == NSCollectionElementKindSectionHeader && view) {
        // [view removeFromSuperview];
        // NSLog(@"### didEndDisplayingSupplementaryView %@", kind);
    }

}


#pragma mark NSCollectionViewDelegateFlowLayout

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.dataSource.semanticMode) {
//        return NSMakeSize(215, 31);
//    } else {
        return NSMakeSize(31, 31);
//    }
    
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return NSMakeSize(0, 26);

}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return NSMakeSize(0, 0);
}

@end
