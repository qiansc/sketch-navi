//
//  NVTextField.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "NVTextField.h"

@implementation NVTextField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor {
    NSLog(@"NAVIL EDTING %@", fieldEditor.string);
    return true;
}

-(void)controlTextDidEndEditing:(NSNotification *)obj{
    NSLog(@"NAVIL EDTING1 %@", self.stringValue);
}

-(void)controlTextDidChange:(NSNotification *)obj{
    NSLog(@"NAVIL EDTING2 %@", self.stringValue);
}

-(void)controlTextDidBeginEditing:(NSNotification *)obj{
    NSLog(@"NAVIL EDTING3 %@", self.stringValue);
}

@end
