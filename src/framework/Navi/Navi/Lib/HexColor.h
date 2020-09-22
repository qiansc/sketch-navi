//
//  HexColor.h
//  Navi
//
//  Created by QIANSC on 2020/9/22.
//  Copyright © 2020 Qian,Sicheng. All rights reserved.
//

#define NSColorFromRGB(rgbValue) [NSColor colorWithDeviceRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]
