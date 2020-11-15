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

- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _minWidth = 40;
        _maxWidth = 40;
        self.menuView.controller.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.controller.delegate = self;
}

- (void)togglePanel:(NSString *)panelId state:(BOOL)state {
    if (state)
        [self.panelView.controller scrollToPanel:panelId];
}

- (void)toggleMain:(BOOL)state{
    _minWidth = state? 280 : 40;
    _maxWidth = state? 9999  : 40;
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
