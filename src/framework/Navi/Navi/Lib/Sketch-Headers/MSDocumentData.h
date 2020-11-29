//
//  MSDocumentData.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/26.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSLayer.h"

@interface MSDocumentData: NSObject

@property (readonly, strong) NSArray *layers;

- (MSLayer*)getLayerWithID:(NSString*)layerId;
- (MSLayer*)layerWithID:(NSString*)layerId;
- (MSLayer*)layersByObjectID:(id)layerId;


@end
