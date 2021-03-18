//
//  MSOverlayItemDataSource.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/12.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

@protocol MSOverlayItemDataSource <NSObject>
- (MSOverlayItemContainer *)overlayItems:(unsigned long long)arg1 parameters:(struct MSRenderingParameters)arg2;
- (NSDictionary *)overlayItemImages:(struct CGColorSpace *)arg1 backingScale:(double)arg2;
@end
