//
//  MSDocument.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSLayer.h"
#import "MSPage.h"
#import "MSDocumentData.h"
#import "MSCanvasView.h"
#import "MSMainSplitViewController.h"

@interface MSDocument: NSDocument

@property (nonatomic, strong) NSArray *selectedLayers;
@property (nonatomic, strong) NSWindow *documentWindow;
@property (readonly, strong) NSArray<MSPage*> *pages;
@property (readonly, strong) MSDocumentData *documentData;
@property (readonly, strong) MSPage *currentPage;
@property (readonly, strong) MSCanvasView *contentDrawView;

@property(readonly, nonatomic) MSMainSplitViewController *splitViewController;

-(void)showMessage:(NSString *) text;

- (id)currentHandler;

@end
