//
//  Util.m
//  Navi
//
//  Created by Qian,Sicheng on 2020/10/12.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#import "Util.h"
#import "HexColor.h"

@implementation Util

+ (NSImage*)createImage:(NSURL*) imageURL withSize:(NSSize) size {
    NSImage* image = [[NSImage alloc]initWithContentsOfURL:imageURL];
    [image setSize:size];
    [image setScalesWhenResized:YES];
    return image;
}

+ (NSBox*)separtorBox {
    NSBox *separtorBox = [[NSBox alloc]initWithFrame:NSZeroRect];
    [separtorBox setBoxType:NSBoxSeparator];
    [separtorBox setBorderColor:NSColorFromRGBString(@"#F5F5F5")];
    return separtorBox;
}
@end
