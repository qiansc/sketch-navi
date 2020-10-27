//
//  NVTextSectionHeader.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/27.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVTextSectionHeader.h"

@implementation NVTextSectionHeader {
    NSTextField *textField;
}


- (void)viewWillMoveToSuperview:(NSView *)superview{
    [super viewWillMoveToSuperview:superview];
    if (textField == nil) {
        textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 18)];
        // textField.stringValue = [self.source getDims][indexPath.section];
        textField.editable = NO;
        textField.bordered = NO;
        textField.stringValue = @"title";
        textField.textColor = [NSColor grayColor];
        textField.drawsBackground = NO;
        [textField setFont:[NSFont systemFontOfSize: 10]];
        // textField.cell.font.pointSize
        [self addSubview:textField];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}

-(void)setTitle:(NSString *) title {
    textField.stringValue = title;
}


@end
