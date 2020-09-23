//
//  ColorMiniPanel.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/9/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "ColorMiniPanel.h"
#import "ColorMiniButtonView.h"

@implementation ColorMiniPanel

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewDidAppear {
    [super viewDidAppear];

}

- (void)viewDidLayout {
    [super viewDidLayout];
}

- (void)initUI {
    NSArray *colorValues = [NSArray arrayWithObjects:@"4C4BF3", @"4E6EF2", @"D089FF", @"CFC0FF", @"CBF8FF", @"FBE98A", @"4C4BDD", @"4E6EFF", nil];
    NSArray *samValues = [NSArray arrayWithObjects:@"SAM_001", @"SAM_002", @"SAM_003", @"SAM_004", @"SAM_005", @"SAM_006", @"SAM_007", @"SAM_008", nil];

    NSArray *subviews = [[self view]subviews];
    NSUInteger count = 0;

    for (NSView *view in subviews) {
        if ([view.identifier hasPrefix:@"CBTN"]) {
            ColorMiniButtonView *button = ((ColorMiniButtonView *)view);
            button.toolTip = samValues[count];
            button.colorString = colorValues[count];
            // target action 事件绑定
            [button setTarget:self];
            [button setAction:@selector(buttonClick:)];
            count++;
        }
    }
}

-(void)buttonClick:(ColorMiniButtonView*)sender {
    [self selectMiniButton: sender];
}

+ (instancetype)viewControllerFromNIB {
    
    // 这里一般都写 bundle:[NSBundle mainBundle] 但是以framework形式加载时候会出错
    NSString* const frameworkBundleID  = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    
    return [[ColorMiniPanel alloc] initWithNibName:@"ColorMiniPanel" bundle:resourceBundlePath];
}

- (NSView *)viewWithIdentifier:(NSString *)identifier
{
    NSArray *subviews = [[self view]subviews];

    for (NSView *view in subviews) {
        if ([view.identifier isEqualToString:identifier]) {
            return view;
        }
    }

    return nil;
}

// 选中某个指定button
- (void) selectMiniButton:(ColorMiniButtonView *) button {
    if (self.selectedCode == button.toolTip) {
        return;
    }
    [self select:button.toolTip];
}

// 选择某一种colorCode的Button
- (void)select:(NSString *) colorCode {
    NSArray *subviews = [[self view]subviews];
    NSUInteger count = 0;
    for (NSView *view in subviews) {
        if ([view.identifier hasPrefix:@"CBTN"]) {
            if (view.toolTip != colorCode &&
                ((ColorMiniButtonView *)view).selected == YES) {
                ((ColorMiniButtonView *)view).selected = NO;
                [((ColorMiniButtonView *)view) updateState];
            }
            count++;
        }
    }
    self.selectedCode = colorCode;
}

// 子按钮选中态重置
- (void)reset {
    for (NSView *view in [[self view]subviews]) {
        if ([view.identifier hasPrefix:@"CBTN"]) {
            ((ColorMiniButtonView *)view).selected = NO;
            [((ColorMiniButtonView *)view) updateState];
        }
    }
}

@end
