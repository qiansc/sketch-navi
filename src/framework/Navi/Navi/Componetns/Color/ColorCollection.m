//
//  ColorCollection.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorCollection.h"
#import "ColorCollectionView.h"

@interface ColorCollection ()

@end

@implementation ColorCollection {
//    NSCollectionViewFlowLayout *l;
    float height;
}

//- (void)loadView {
//    NSCollectionView *view = [[ColorCollectionView alloc]init];
//    NSCollectionViewFlowLayout *layout = [[NSCollectionViewFlowLayout alloc]init];
//    view.collectionViewLayout = layout;
//    self.view = view;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSCollectionView *view = self.view;
    
//    NSLog(@"NAVIL CCCC %@", view.superview);
//
//    NSArray<NSLayoutConstraint *> * c = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|[view]|" options:0 metrics:nil views:
//                                         [NSDictionary dictionaryWithObject:self.view forKey:@"view"]];

//    [self.view.superview addConstraints:c];
    NSLog(@"NAVIL XXXXXXXXXXX %f", self.view.superview.superview.frame.size.height);
    // (ColorCollectionView *)self.view
    // Do view setup here.
}

- (void)viewWillLayout {
    NSLog(@"NAVIL XXXXXXXXXXX viewWillLayout %f", self.view.superview.superview.frame.size.height);
    // 保持宽度和superview一致
//    self.view.frame = NSMakeRect(self.view.frame.origin.x, self.view.frame.origin.y, self.view.superview.frame.size.width, self.view.frame.size.height);
//    self.view.superview.frame = NSMakeRect(self.view.superview.frame.origin.x, self.view.superview.frame.origin.y, self.view.superview.frame.size.width, self.view.frame.size.height);
    [super viewWillLayout];
}

- (void)viewDidLayout {
    [super viewDidLayout];
    // 保持superview高度和自己一致
    NSLog(@"NAVIL XXXXXXXXXXX viewDidLayout %f", self.view.superview.superview.frame.size.height);
    NSLog(@"NAVIL YYYY viewDidLayout %f %f %f", self.view.frame.size.height, self.view.superview.frame.size.height, self.view.superview.superview.frame.size.height);
    // self.view.superview.frame = NSMakeRect(self.view.superview.frame.origin.x, self.view.superview.frame.origin.y, self.view.superview.frame.size.width, self.view.frame.size.height);
    if (height != self.view.frame.size.height) {
        height = self.view.frame.size.height;
        NSRect SSframe = self.view.superview.superview.superview.frame;
        if (self.layoutHandler) {
            self.layoutHandler(self.view.frame.size.height);
        }
    }

}

@end
