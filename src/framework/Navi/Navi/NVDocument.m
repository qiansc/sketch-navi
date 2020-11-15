//
//  NVDocument.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/11/11.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVDocument.h"

@interface NVDocument ()

@end

@implementation NVDocument

- (void)viewDidLoad {
    [super viewDidLoad];
    _minWidth = 40;
    _maxWidth = 9999;
    self.view.wantsLayer = true;
    self.view.layer.backgroundColor = [NSColor greenColor].CGColor;
    self.menuView.controller.delegate = self;
    // Do view setup here.
}

- (void)togglePanel:(NSString *)panelId state:(BOOL)state {
    if (state)
        [self.panelView.controller scrollToPanel:panelId];
}

- (void)toggleMain:(BOOL)state{
    _minWidth = state? 40 : 280;
    _maxWidth = state? 40 : 9999;
    [self viewWillLayout];
    NSLog(@"### main state %hhd", state);
}

-  (void)viewWillLayout {
    [super viewWillLayout];
    if (self.delegate) {
        [self.delegate viewWillLayout];
    }
}

@end
