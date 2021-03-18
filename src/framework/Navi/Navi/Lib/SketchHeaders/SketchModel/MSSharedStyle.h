//
//  MSSharedStyle.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//


#import "_MSSharedStyle.h"

@interface MSSharedStyle : _MSSharedStyle
{
}

- (id)initWithName:(id)arg1 style:(id)arg2;
@property(readonly, nonatomic) MSStyle *style;
- (void)correctInvalidGamma;
@property(readonly, nonatomic) NSString *currentObjectID_MSSharedObjectPasting;
- (id)handlePasteIntoDocument:(id)arg1;
- (void)updateToMatch:(id)arg1;
- (void)resetReferencingInstances;
- (id)allInstances;
- (id)allLayersInstances;

@end
