//
//  wsc_zui_define.h
//  wsc_zui
//
//  Created by smf on 17/1/18.
//  Copyright © 2017年 smf. All rights reserved.
//

#ifndef wsc_zui_define_h
#define wsc_zui_define_h

#define SYSTEMVERSION  [[UIDevice currentDevice] systemVersion].floatValue

#define DEVICE_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT  [[UIScreen mainScreen] bounds].size.height

#define LOAD_ERROR @"服务器请求错误"

//颜色
#define colorRed 0xff5050
#define colorGraySeparator 0xD9D9D9
#define colorSearchBarBG 0xf0f0f0
#define navigationTint 0x505050
#define colorBlue 0x56ABE4 //0x1a90f0
#define colorBlueGray 0x80abc3
#define colorGray 0xB4B4B4

#pragma mark - 单例模板
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0; \
__strong static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = block(); \
}); \
return sharedInstance; \


#define UIColorFromRGB(rgbValue)                                                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
alpha:1.0]

#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]


#endif /* wsc_zui_define_h */
