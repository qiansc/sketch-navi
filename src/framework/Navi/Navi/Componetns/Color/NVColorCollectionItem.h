//
//  NVColorCollectionItem.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/16.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVColorSource.h"
#import "NVColorCollectionItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVColorCollectionItem : NSCollectionViewItem


@property (strong) IBOutlet NVColorCollectionItemView *view;
@property (strong) IBOutlet NSTextField *textFiled;
@property (strong) IBOutlet NSBox *frontBox;

- (void)initWithSpec:(NVColorSpec) spec;

@end

NS_ASSUME_NONNULL_END
