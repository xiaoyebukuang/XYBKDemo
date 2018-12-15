//
//  UtilsMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

/** 系统版本 */
#define IS_IOS_VERSION   floorf([[UIDevice currentDevice].systemVersion floatValue])
#define IS_IOS_9    floorf([[UIDevice currentDevice].systemVersion floatValue]) >=9.0 ? 1 : 0
#define IS_IOS_10   floorf([[UIDevice currentDevice].systemVersion floatValue]) >=10.0 ? 1 : 0
#define IS_IOS_11   floorf([[UIDevice currentDevice].systemVersion floatValue]) >=11.0 ? 1 : 0
#define IS_IOS_12   floorf([[UIDevice currentDevice].systemVersion floatValue]) >=12.0 ? 1 : 0


/** 字体 */
#define SYSTEM_BOLD_FONT(FONTSIZE)      [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEM_FONT(FONTSIZE)           [UIFont systemFontOfSize:FONTSIZE]

#define SYSTEM_FONT_24                  SYSTEM_FONT(24)
#define SYSTEM_FONT_18                  SYSTEM_FONT(18)
#define SYSTEM_FONT_14                  SYSTEM_FONT(14)
#define SYSTEM_FONT_B_14                SYSTEM_BOLD_FONT(14)


#endif /* UtilsMacros_h */
