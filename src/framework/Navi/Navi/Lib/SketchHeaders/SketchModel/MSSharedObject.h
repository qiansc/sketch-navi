//
//  MSSharedObject.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "_MSSharedObject.h"

@interface MSSharedObject : _MSSharedObject
{
}

+ (id)defaultName;
- (id)parentGroup;
- (unsigned long long)type;
- (BOOL)isOutOfSyncWithInstance:(id)arg1;
- (id)initWithName:(id)arg1 sharedObjectID:(id)arg2 value:(id)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly, nonatomic) NSString *name;
@property(readonly) Class superclass;

@end
