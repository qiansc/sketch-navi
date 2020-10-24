//
//  NVLineSectionHeader.m
//  Navi
//
//  Created by Bi,Yingshuai on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVLineSectionHeader.h"

@implementation NVLineSectionHeader {
    NSTextField *textField;
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    [super viewWillMoveToSuperview:newSuperview];
    if (textField == nil) {
        textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 18)];
        textField.editable = NO;
        textField.bordered = NO;
        textField.stringValue = @"title";
        textField.textColor = [NSColor grayColor];
        textField.drawsBackground = NO;
        [textField setFont:[NSFont systemFontOfSize: 10]];
        [self addSubview:textField];
    }
}

- (void) setTitle:(NSString *)title {
    textField.stringValue = title;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
