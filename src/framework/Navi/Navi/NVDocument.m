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
    self.view.wantsLayer = true;
    self.view.layer.backgroundColor = [NSColor greenColor].CGColor;
    // Do view setup here.
}

-  (void)viewWillLayout {
    [super viewWillLayout];
    if (self.delegate) {
        [self.delegate viewWillLayout];
    }
}

@end
