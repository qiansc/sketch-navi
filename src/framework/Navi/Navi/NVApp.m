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
    [NVAppCache cacheApp:self with:document];
    navi = [[NVDocument alloc] initWithNibName:@"NVDocument" bundle:[NVBundle bundlePath]];
    navi.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delayUpdateSpec) name:@"SPEC_UPDATE" object:nil];
    return self;
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
    NSMutableArray *views = [NSMutableArray new];
    for(NSView *view in self.splitView.subviews) {
        [views addObject:view];
        if ([view.identifier isEqual:@"view_canvas"]) {
            [views addObject:navi.view];
        }
    }
    self.splitView.subviews = views;
    [self.splitView adjustSubviews];
    [self viewWillLayout];
    
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
    [navi.view removeFromSuperview];
    [self.splitView adjustSubviews];
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



- (void)viewWillLayout {
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
