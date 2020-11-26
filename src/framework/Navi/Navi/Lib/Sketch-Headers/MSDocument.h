//
//  MSDocument.h
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/21.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "MSLayer.h"
#import "MSPage.h"
#import "MSDocumentData.h"

@interface MSDocument: NSDocument

@property (nonatomic, strong) NSArray *selectedLayers;
@property (nonatomic, strong) NSWindow *documentWindow;
@property (readonly, strong) NSArray<MSPage*> *pages;
@property (readonly, strong) MSDocumentData *documentData;

-(void)showMessage:(NSString *) text;

@end
