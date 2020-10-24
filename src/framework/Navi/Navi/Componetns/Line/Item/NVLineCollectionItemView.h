//
//  NVLineCollectionItemView.h
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVToggleBox.h"
#import "NVLineSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVLineCollectionItemView : NVToggleBox

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (nonatomic) NVLineSpec spec;

@end

NS_ASSUME_NONNULL_END
