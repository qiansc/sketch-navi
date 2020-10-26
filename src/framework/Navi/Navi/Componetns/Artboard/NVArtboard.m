//
//  NVArtboard.m
//  Navi
//
//  Created by QIANSC on 2020/10/26.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVArtboard.h"
#import "MSDocument.h"

@interface NVArtboard ()

@end

@implementation NVArtboard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.confirmButton setTarget:self];
    [self.confirmButton setAction:@selector(confirmInfo:)];
    [self.closeButton setTarget:self];
    [self.closeButton setAction:@selector(closeWindow:)];
//
//    NSLog(@"NAVIL %@ %@", self.closeButton.target, self.closeButton.action);
}

-(void)closeWindow:(NSButton*) button {
     [self.window close];
}
-(void)confirmInfo:(NSButton*) button {
    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"转换中，请稍后...%@", @""]];
     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(finishInfo) userInfo:nil repeats:NO];
}
-(void)finishInfo {
    [((MSDocument *)[[[NSApplication sharedApplication] orderedDocuments] firstObject]) showMessage:[NSString stringWithFormat:@"转换完成！%@", @""]];
    [self.window close];
}

+ (instancetype)viewControllerFromNIB {
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    return[[NVArtboard alloc] initWithNibName:@"NVArtboard" bundle:resourceBundlePath];
}

@end
