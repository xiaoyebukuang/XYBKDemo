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

//TODO:字体
#define SYSTEM_BOLD_FONT(FONTSIZE)      [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEM_FONT(FONTSIZE)           [UIFont systemFontOfSize:FONTSIZE]
#define SYSTEM_FONT_B_45                SYSTEM_BOLD_FONT(48)
#define SYSTEM_FONT_B_40                SYSTEM_BOLD_FONT(40)
#define SYSTEM_FONT_40                  SYSTEM_FONT(40)
#define SYSTEM_FONT_B_36                SYSTEM_BOLD_FONT(36)
#define SYSTEM_FONT_36                  SYSTEM_FONT(36)
#define SYSTEM_FONT_34                  SYSTEM_FONT(34)
#define SYSTEM_FONT_32                  SYSTEM_FONT(32)
#define SYSTEM_FONT_B_30                SYSTEM_BOLD_FONT(30)
#define SYSTEM_FONT_B_27                SYSTEM_BOLD_FONT(27)
#define SYSTEM_FONT_27                  SYSTEM_FONT(27)
#define SYSTEM_FONT_B_26                SYSTEM_BOLD_FONT(26)
#define SYSTEM_FONT_B_25                SYSTEM_BOLD_FONT(25)
#define SYSTEM_FONT_B_24                SYSTEM_BOLD_FONT(24)
#define SYSTEM_FONT_24                  SYSTEM_FONT(24)
#define SYSTEM_FONT_B_23                SYSTEM_BOLD_FONT(23)
#define SYSTEM_FONT_23                  SYSTEM_FONT(23)
#define SYSTEM_FONT_B_22                SYSTEM_BOLD_FONT(22)
#define SYSTEM_FONT_22                  SYSTEM_FONT(22)
#define SYSTEM_FONT_B_21                SYSTEM_BOLD_FONT(21)
#define SYSTEM_FONT_21                  SYSTEM_FONT(21)
#define SYSTEM_FONT_B_20                SYSTEM_BOLD_FONT(20)
#define SYSTEM_FONT_20                  SYSTEM_FONT(20)
#define SYSTEM_FONT_B_19                SYSTEM_BOLD_FONT(19)
#define SYSTEM_FONT_B_18                SYSTEM_BOLD_FONT(18)
#define SYSTEM_FONT_18                  SYSTEM_FONT(18)
#define SYSTEM_FONT_B_17                SYSTEM_BOLD_FONT(17)
#define SYSTEM_FONT_17                  SYSTEM_FONT(17)
#define SYSTEM_FONT_B_16                SYSTEM_BOLD_FONT(16)
#define SYSTEM_FONT_16                  SYSTEM_FONT(16)
#define SYSTEM_FONT_15                  SYSTEM_FONT(15)
#define SYSTEM_FONT_14                  SYSTEM_FONT(14)
#define SYSTEM_FONT_B_14                SYSTEM_BOLD_FONT(14)
#define SYSTEM_FONT_13                  SYSTEM_FONT(13)
#define SYSTEM_FONT_B_13                SYSTEM_BOLD_FONT(13)
#define SYSTEM_FONT_B_12                SYSTEM_BOLD_FONT(12)
#define SYSTEM_FONT_12                  SYSTEM_FONT(12)
#define SYSTEM_FONT_11                  SYSTEM_FONT(11)
#define SYSTEM_FONT_B_11                SYSTEM_BOLD_FONT(11)
#define SYSTEM_FONT_B_10                SYSTEM_BOLD_FONT(10)
#define SYSTEM_FONT_10                  SYSTEM_FONT(10)
#define SYSTEM_FONT_B_9                 SYSTEM_BOLD_FONT(9)
#define SYSTEM_FONT_9                   SYSTEM_FONT(9)
#define SYSTEM_FONT_B_8                 SYSTEM_BOLD_FONT(8)
#define SYSTEM_FONT_8                   SYSTEM_FONT(8)
#define SYSTEM_FONT_B_7                 SYSTEM_BOLD_FONT(7)
#define SYSTEM_FONT_7                   SYSTEM_FONT(7)
#define SYSTEM_FONT_6                   SYSTEM_FONT(6)
#define SYSTEM_FONT_B_5                 SYSTEM_BOLD_FONT(5)
#define SYSTEM_FONT_5                   SYSTEM_FONT(5)





#endif /* UtilsMacros_h */
