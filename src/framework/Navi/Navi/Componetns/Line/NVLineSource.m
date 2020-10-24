//
//  NVLineSource.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineSource.h"

@implementation NVLineSource {
    NSString *searchQuery;
}

- (void)update:(NSArray<NSDictionary*> *) specs {
    
}

- (void)onUpdated:(NVSourceUpdateCallback) callback {
    
}

- (void)setQuery:(NSString *) query {
    searchQuery = query;
}

@end
