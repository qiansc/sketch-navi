//
//  LinePanel.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/9.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "LinePanel.h"
#import "LineCellView.h"

@implementation LinePanel

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initUI];
    // Do view setup here.
}

- (void)viewDidAppear {
    [super viewDidAppear];

}

- (void)viewDidLayout {
    [super viewDidLayout];
}

- (void)initUI {
    NSArray *subviews = [[self view]subviews];
    for (NSView *view in subviews) {
        if ([view.identifier hasPrefix:@"LCELL"]) {
            NSBox *box = ((NSBox *) view);
            LineCellView *button = ((LineCellView *) box.subviews[0]);
            button.lineSize = @2; // TODO: get size from data
            [button setTarget:self];
            [button setAction:@selector(buttonClick)];
        }
    }
}

-(void)buttonClick:(LineCellView *) sender {
    [self selectLineCell: sender];
}

-(void)selectLineCell:(LineCellView *) button {
    if (self.selectedCode == button.toolTip) {
        return;
    }
    [self select:button.toolTip];
}

-(void)select:(NSString *) lineCode {
    NSArray *subviews = [[self view]subviews];
    NSUInteger count = 0;
    for (NSView *view in subviews) {
        if ([view.identifier hasPrefix:@"LCELL"]) {
            NSBox *box = ((NSBox *) view);
            LineCellView *line = ((LineCellView *) box.subviews[0]);
            if (line.toolTip != lineCode && line.selected == YES) {
                line.selected = NO;
                [line updateState];
            } else if (line.toolTip == lineCode && line.selected == NO) {
                line.selected = YES;
                [line updateState];
            }
            count++;
        }
    }
    self.selectedCode = lineCode;
    if (self.delegate) {
//        [self.delegate lineChange:lineCode];
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   
    return self;
}

+ (instancetype)viewControllerFromNIB {
    NSString* const frameworkBundleID = @"com.baidu.Navi";
    NSBundle* resourceBundlePath = [NSBundle bundleWithIdentifier:frameworkBundleID];
    LinePanel* s = [[LinePanel alloc] initWithNibName:@"LinePanel" bundle:resourceBundlePath];
    return s;
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


@end
