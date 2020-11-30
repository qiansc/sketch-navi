//
//  MSPage.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/26.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//
#import "MSLayer.h"
#import "MSArtboardGroup.h"
#import "MSLayerArray.h"

@interface MSPage: NSObject

@property(nonatomic) __weak MSArtboardGroup *currentArtboard;

-(void)addLayer:(MSLayer*) layer;


@end
