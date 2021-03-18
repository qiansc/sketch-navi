//
//  NVApp.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/10.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVApp.h"
#import "NVAppCache.h"
#import "NVBundle.h"
#import "NVSpec.h"
#import "MSCanvasViewController.h"
#import "MSOverlayItemContainer.h"
#import "MSCanvasView.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAMetalLayer.h>
#import <QuartzCore/CATextLayer.h>
#import <QuartzCore/CABase.h>
#import "NVLayerDelegate.h"
#import "CAImageQueue.h"


@implementation NVApp{
    MSDocument *document;
    NVDocument *navi;
    NVSpec *spec;
    
}
+(instancetype)prepareInit{
    NVApp * app = [NVApp new];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:app selector:@selector(delayInit) userInfo:nil repeats:NO];
    return app;
}

+(instancetype)currentApp{
    MSDocument* doc = [[NSDocumentController sharedDocumentController] currentDocument];
    if (doc){
        NVApp *app = [NVAppCache getAppWith:doc];
        if (app) {
            return app;
        }
        return [[NVApp alloc] initWithCurrentDocument];
    }
    return nil;
}

-(instancetype)initWithCurrentDocument{
    document = [[NSDocumentController sharedDocumentController] currentDocument];
    if (document == nil) {
        MSDocument *last = [[[NSDocumentController sharedDocumentController] documents] lastObject];
        if ([NVAppCache getAppWith: last] == nil) {
            document = last;
        }
    }
    
    [NVAppCache cacheApp:self with:document];
    navi = [[NVDocument alloc] initWithNibName:@"NVDocument" bundle:[NVBundle bundlePath]];
    navi.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delayUpdateSpec) name:@"SPEC_UPDATE" object:nil];
    // [self monitor];
    return self;
}

-(void)monitor {
    NSLog(@"### monitor");
//    MSCanvasViewController *c = document.splitViewController.splitViewItems[1].viewController;
//    NSView *canvasContainerView = c.view.subviews[0];
//    MSCanvasView *canvasView = canvasContainerView.subviews[3];
//    NVLayerDelegate *delegate = [[NVLayerDelegate alloc] init:canvasView];
//    NSLog(@"### canvasView.layer.delegate %@ || %@", canvasView.layer.delegate, canvasView);
//    canvasView.layer.delegate = delegate;
//    NSLog(@"### delegate has bind!");
//    NSLog(@"### canvasView.layer.delegate %@ || %@", canvasView.layer.delegate, canvasView);

    

    id monitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull e) {
        //判断aEvent.keyCode属性
//        NSLog(@"### gogogo1 %@", e.window);
//        NSLog(@"### gogogo2 %hu", e.keyCode);
        // NSLog(@"### gogogo3 %@", e.trackingArea.options);
        
        MSCanvasViewController *c = document.splitViewController.splitViewItems[1].viewController;
        NSView *canvasContainerView = c.view.subviews[0];
        NSLog(@"### 0 code: %hu", e.keyCode);
        NSTextField *text =  [[NSTextField alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
        text.backgroundColor = [NSColor clearColor];
        text.stringValue = @"静态文本";
        [text setTextColor:[NSColor redColor]];
        [text setFont:[NSFont systemFontOfSize:10]];
        // [canvasContainerView addSubview: text];
        
        MSCanvasView *canvasView = canvasContainerView.subviews[3];
        NSLog(@"### 0 canvasContainerView subviews: %@", canvasContainerView.subviews);
        NSStackView *stackView = canvasView.subviews[0];
        // canvasView
        MSPage *page = canvasView.currentPage;
        // MSLayer *layer = page.selectedLayers[0];
        NSLog(@"### 0.1");
        
        CATextLayer * ygTextLayer = [CATextLayer layer];
        ygTextLayer.frame           = CGRectMake(20, 64+100, 300, 35);
        ygTextLayer.backgroundColor = [NSColor yellowColor].CGColor;
        ygTextLayer.string = @"CATextLayer";
        //字体的大小
        ygTextLayer.fontSize = 18.f;
        //字体的对齐方式
        ygTextLayer.alignmentMode = kCAAlignmentCenter;
        // MSLayer *layer= page.selectedLayers[0];

        NSLog(@"### 1 canvasView.layer.sublayers %@ ||  %@ ", canvasView.layer ,canvasView.layer.sublayers);
        CALayer *bglayer = canvasView.layer.sublayers[0];
        CAMetalLayer *clayer = canvasView.layer.modelLayer;
        // NSLog(@"### 1.2 layer object: %@", layer model);
        
        NSLog(@"### 2.0 canvasView.layer.actions : %@", canvasView.layer.actions);
        NSLog(@"### 2.2 clayer.contents: %@", clayer.contents);
        
        MSOverlayItemContainer *container;
        // @try {
        MSRenderingParameters p = {
            // ._field1 = NSMakeRect(0, 0, 100, 100),
//            ._field2 = 0,
//            ._field3 = 0,
            // ._field4 = NSMakeSize(100, 100),
//            ._field5 = 0,
        };
        container = [canvasView overlayItems:0 parameters: p];
        NSLog(@"### 4 container.flowItems : %@", [container flowItems]);
        NSLog(@"### 5 container.pathItems : %@", [container pathItems]);

//            NSLog(@"### TRY 001");
//            MSPath *path = [[[NVBundle SketchModelBundle] classNamed: @"MSPath"] pathWithLineFrom: NSMakePoint(0, 0) to: NSMakePoint(0, 100)];
//            NSLog(@"### TRY 002");
//            MSOverlayPathItem *pathItem = [[[NVBundle SketchRenderingBundle] classNamed: @"MSOverlayPathItem"] itemForPath:path transform:CGAffineTransformMake(1,0,0,1,0,0) color:NSColorFromRGBString(@"888888").CGColor lineWidth:1];
//            NSLog(@"### TRY 003 %@ %@", path, pathItem);
//            NSArray *arr = @[@[pathItem], @[pathItem], @[pathItem], @[pathItem]];
//            [container initWithPathItems:arr bitmapItems:@[] labelItems:@[]];
//
//            NSLog(@"### 8 container.pathItems : %@", [container pathItems]);
//            [container appendingItems: arr];
        // }@catch(NSException *exception) {
            // NSLog(@"### catch %@ %@ %@", exception.description, exception.debugDescription, exception.callStackReturnAddresses);
            // NSLog(@"### catc h%@ %@ %@", exception.callStackSymbols, exception.reason, exception.userInfo);
            
        // }
//        [c updateContentSettings];
//        [c updateOverlaySettings];
        

        
        
        
        
        // [page setIsVisible:NO];
        // [page add]
        
        // [canvasContainerView.subviews[2] setHidden:YES];
       //  [canvasView addSubview: text];
        
        return e;
    }];
    // [NSEvent removeMonitor:monitor];
}

-(void)toggle{
    if (navi.view.superview)
        [self hide];
    else
        [self show];
}

- (void)delayInit {
    [self initWithCurrentDocument];
    [self show];
}

-(void)show{
    [Util generateConfig];
    if ([Util sketchVersion] >=70) {
        NSViewController *c= [NSViewController new];
        c.view = navi.view;
        self.wrapper = [NSSplitViewItem splitViewItemWithViewController:c];
        self.wrapper.holdingPriority = NSLayoutPriorityFittingSizeCompression;
        [document.splitViewController insertSplitViewItem:self.wrapper atIndex:2];
    } else {
        NSMutableArray *views = [NSMutableArray new];
        for(NSView *view in self.splitView.subviews) {
            [views addObject:view];
            if ([view.identifier isEqual:@"view_canvas"]) {
                [views addObject:navi.view];
            }
        }
        self.splitView.subviews = views;
        [self.splitView adjustSubviews];
    }

    [self viewWillLayout];
    [self viewLimitBetweenMinimum: navi.minWidth andMaximum:navi.maxWidth];

    if (spec == nil) {
        [self updateSpec];
    }
}

-(void)updateSpec{
    spec = [[NVSpec alloc] init];
    [spec load];
    self.specs = [spec getSpec];
    if (self.dataSource) {
        [self.dataSource updateSpec];
    }
    [navi.panelView.controller updateSpec:self.specs];
    [navi.menuView.controller updateSpec:self.specs];
}

-(void)delayUpdateSpec {
    [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(updateSpec) userInfo:nil repeats:NO];
}

-(void)hide{
    if ([Util sketchVersion] >=70) {
        [navi toggleMain:NO];
        [self removeWrapper];
        [self removeBlankWrapper];
    } else {
        [navi.view removeFromSuperview];
        [self.splitView adjustSubviews];
    }
}

-(NSString*)bundlePath {
    return [NVBundle bundlePath].bundlePath;
}
-(MSSplitView *)splitView{
    for(NSView * view in document.documentWindow.contentView.subviews) {
        if ([[view className] isEqual:@"MSSplitView"])
            return (MSSplitView *)view;
    }
    return nil;
}

-(void)removeWrapper {
    int index = [document.splitViewController.splitViewItems indexOfObject:self.wrapper];
    if (index > -1) {
        [document.splitViewController removeSplitViewItem:self.wrapper];
    }
}

-(void)removeBlankWrapper {
    int index = [document.splitViewController.splitViewItems indexOfObject:self.blankWrapper];
    if (index > -1) {
        [document.splitViewController removeSplitViewItem:self.blankWrapper];
    }
}

-(void)viewLimitBetweenMinimum:(float)minWidth andMaximum:(float)maxWidth {
    if ([Util sketchVersion] >= 70) {
        if (maxWidth == minWidth) {
            [self removeBlankWrapper];
        } else {
            int index = [document.splitViewController.splitViewItems indexOfObject:self.wrapper];
            NSViewController *empty = [NSViewController new];
            empty.view = [NSView new];
            self.blankWrapper = [NSSplitViewItem splitViewItemWithViewController:empty];
            self.blankWrapper.minimumThickness = 0;
            self.blankWrapper.maximumThickness = 0;
            [document.splitViewController insertSplitViewItem:self.blankWrapper atIndex:index];
            // 初次触发一次layout
            long nextPos = [self.splitView maxPossiblePositionOfDividerAtIndex:index];
            [self.splitView setPosition:nextPos ofDividerAtIndex:index];
        }
        self.wrapper.minimumThickness = minWidth;
        self.wrapper.maximumThickness = maxWidth;
    }
}

- (void)viewWillLayout {
    if ([Util sketchVersion] < 70) {
        NSSplitView *parent = self.splitView;
        NSView *subview = navi.view;
        long index = [parent.subviews indexOfObject:navi.view];
        if (index > 0 && [parent.subviews objectAtIndex:index + 1]) {
            long x = [parent maxPossiblePositionOfDividerAtIndex:index - 1] - subview.frame.size.width;
            long nextWith = parent.subviews[index +1].frame.size.width;
            long nextPos = [parent maxPossiblePositionOfDividerAtIndex:index];
            long startX = nextPos -nextWith -  navi.minWidth;
            long endX =  nextPos -nextWith - navi.maxWidth;
            if (x > startX) {
                [parent setPosition:startX ofDividerAtIndex: index - 1];
            } else if(x < endX) {
                [parent setPosition:endX ofDividerAtIndex: index - 1];
            }
        }
    }
}


-(void)selectionChange{
    [navi.panelView.controller selectionChange];
}

-(void)onPaste{
    [navi.panelView.controller onPaste];
}

-(void)beforeCopy{
    [navi.panelView.controller beforeCopy];
}

@end
