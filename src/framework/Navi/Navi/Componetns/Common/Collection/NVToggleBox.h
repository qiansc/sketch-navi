//
//  NVCollectionItemView.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/20.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NVCollectionItemCallback)(NSEvent * event);


@interface NVToggleBox : NSBox

-(void)onMouseEntered:(NVCollectionItemCallback) callback;
-(void)onMouseExited:(NVCollectionItemCallback) callback;
-(void)onMouseDown:(NVCollectionItemCallback) callback;
-(void)oMouseUp:(NVCollectionItemCallback) callback;


@end

NS_ASSUME_NONNULL_END
