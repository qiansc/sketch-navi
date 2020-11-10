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

typedef void (^NVCollectionItemCallback)(NSEvent * event, NSBox* box);

@interface NVToggleBox : NSBox

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) BOOL isHover;
@property (nonatomic) BOOL isSelected;

-(void)reset;
-(void)onMouseEntered:(NVCollectionItemCallback) callback;
-(void)onMouseExited:(NVCollectionItemCallback) callback;
-(void)onMouseDown:(NVCollectionItemCallback) callback;
-(void)oMouseUp:(NVCollectionItemCallback) callback;

- (void)setBased;
- (void)setActived;
- (void)setUnActived;
- (void)setSelected;

- (void)drawStyle;

@end

NS_ASSUME_NONNULL_END
