//
//  NVTextField.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/23.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVTextField : NSTextField<NSControlTextEditingDelegate>

-(BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor;
-(void)controlTextDidEndEditing:(NSNotification *)obj;

-(void)controlTextDidChange:(NSNotification *)obj;

-(void)controlTextDidBeginEditing:(NSNotification *)obj;

@end

NS_ASSUME_NONNULL_END
