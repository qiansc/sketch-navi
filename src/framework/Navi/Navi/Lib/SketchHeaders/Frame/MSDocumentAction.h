//
//  MSDocumentAction.h
//  Navi
//
//  Created by Qian,Sicheng on 2021/3/5.
//  Copyright © 2021 Qian,Sicheng. All rights reserved.
//

#import "MSAction.h"

@interface MSDocumentAction : MSAction
{
    id _document;
    NSTouchBarItem *_cachedTouchedBarItem;
    NSEvent *_previousEvent;
}

@property(nonatomic) __weak NSEvent *previousEvent; // @synthesize previousEvent=_previousEvent;
@property(retain, nonatomic) NSTouchBarItem *cachedTouchedBarItem; // @synthesize cachedTouchedBarItem=_cachedTouchedBarItem;
@property(nonatomic) __weak id *document; // @synthesize document=_document;
- (id)contextForActionObservers;
@property(readonly, nonatomic) NSString *historyMomentTitle;
- (void)performPopUpMenuAction;
- (void)performAction:(id)arg1;
- (void)refreshOverlay;
- (id)canvasView;
- (id)currentPage;
- (void)switchToNormalHandler;
- (id)setCurrentHandlerClass:(Class)arg1;
- (id)toggleHandlerClass:(Class)arg1;
- (id)currentHandler;
- (BOOL)isInNormalHandler;
- (BOOL)validate;
@property(readonly, nonatomic) unsigned long long currentContentMode;
- (id)selectedLayers;
- (id)initWithDocument:(id)arg1;
- (id)menu;
- (void)repopulateMenu:(id)arg1;
- (unsigned long long)touchBarItemSizing;
- (id)touchBarImage;
- (BOOL)isTouchBarItemSelected;
- (BOOL)shouldUseImageForTouchBarItem;
- (void)showTouchBarPopover:(id)arg1;
- (id)makeTouchBarItem;
- (BOOL)touchBarItemButtonShouldShowState;
- (id)makeTouchBarItemButton;
- (void)refreshTouchBarItem;
- (id)touchBarItem;
- (id)touchBar:(id)arg1 makeItemForIdentifier:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

