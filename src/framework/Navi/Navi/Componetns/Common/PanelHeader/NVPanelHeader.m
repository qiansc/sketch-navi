//
//  NVPanelHeader.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/15.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVPanelHeader.h"
#import "NVBundle.h"

@interface NVPanelHeader ()

@end

@implementation NVPanelHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.infoButton setTitle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)toogle:(NSButton*) sender{
//    NSView* view = self.view.superview.superview;
//    NSRect contentFrame = NSMakeRect(0, 0, view.frame.size.width, self.view.frame.size.height);
//    view.frame = contentFrame;
}


+ (instancetype)viewControllerFromNIB {
    return [[NVPanelHeader alloc] initWithNibName:@"NVPanelHeader" bundle:[NVBundle bundlePath]];
}


@end
