//
//  MSArtboardGroup.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/30.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

@interface MSArtboardGroup: NSObject

@property (readonly, strong) MSRect *frame;
-(void)addLayer:(id) layer;

@end
