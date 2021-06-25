//
//  UIColor+Helper.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/20.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_RGB_ALPHA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]
//rgb颜色
#define RGB(r,g,b)                  RGBA(r,g,b,1.0f)
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface UIColor (Helper)

+ (UIColor *)color_hex:(NSString *)hex;

+ (UIColor *)color_random;

+ (UIColor *)color_main;

/** 主色调 */
/** 文字/底部bar图标的主色/tab切换选中色/按钮的颜色/关键词 */
+ (UIColor *)color_FF712C;

+ (UIColor *)color_FF712C_5;

+ (UIColor *)color_FF712C_3;

+ (UIColor *)color_FF712C_04;

/** 选中文字/小标签文字/重要文字/提醒文字 */
+ (UIColor *)color_FF5400;

/** 主题颜色 */
+ (UIColor *)color_000000;

+ (UIColor *)color_000000_1;

+ (UIColor *)color_000000_3;

+ (UIColor *)color_000000_5;

+ (UIColor *)color_000000_6;

+ (UIColor *)color_000000_8;

+ (UIColor *)color_222222;

+ (UIColor *)color_444444;

+ (UIColor *)color_666666;

+ (UIColor *)color_999999;

+ (UIColor *)color_FFFFFF;

+ (UIColor *)color_FFFFFF_0;

+ (UIColor *)color_FFFFFF_3;

+ (UIColor *)color_FFFFFF_5;

+ (UIColor *)color_FFFFFF_9;

/** 提示信息/问题图标 */
+ (UIColor *)color_2C7BFC;

/** 背景色/模块区分色 */
+ (UIColor *)color_F8F8F8;

+ (UIColor *)color_FDFDFD;

+ (UIColor *)color_FF0000;

/** 个人中心订单轮播背景 */
+ (UIColor *)color_FAFBFC;

/** 跑马灯背景 */
+ (UIColor *)color_FFFCE8;

/** 提示背景色 */
+ (UIColor *)color_FFF4EB;

/** 标签选中背景色 */
+ (UIColor *)color_FFF7F3;

/** 线框颜色 */
+ (UIColor *)color_F7F7F7;

+ (UIColor *)color_BBBBBB;

+ (UIColor *)color_EEEEF0;

+ (UIColor *)color_F2F2F2;

+ (UIColor *)color_FDC802;

+ (UIColor *)color_F0F0F0;

+ (UIColor *)color_EEEEEE;

+ (UIColor *)color_EEEEEE_4;

/** 按钮至灰状态颜色/未选中框的颜色/不可点击/其它/图标颜色 */
+ (UIColor *)color_CCCCCC;

/** 价格 */
+ (UIColor *)color_FF3F40;

+ (UIColor *)color_FF3F40_5;

+ (UIColor *)color_48BB04;

+ (UIColor *)color_FF3F3F;

/** 阴影 */
+ (UIColor *)color_CECECE_32;

+ (UIColor *)color_FF6F84_4;

/** 页码颜色 */
+ (UIColor *)color_3775F4;

/** 我的油卡 */
+ (UIColor *)color_FAFAFC;

+ (UIColor *)color_FAFAFA;

/** 券包 */
+ (UIColor *)color_894F1B;

+ (UIColor *)colro_FFFAF1;

/** 代金券 */
+ (UIColor *)color_C5C5C5;

+ (UIColor *)color_644830;

+ (UIColor *)color_644830_7;

+ (UIColor *)color_A08565;

+ (UIColor *)color_806546;

+ (UIColor *)color_FFF1D4;

/** 违章代缴 */
+ (UIColor *)color_01C34D;

+ (UIColor *)color_FEFDEB;

/** 小保养 */
+ (UIColor *)color_FFFAF1;

/** 个人中心 */
+ (UIColor *)color_FAFDFE;

/** 我的爱车 */
+ (UIColor *)color_F5F5F5;

+ (UIColor *)color_EAEBEC;

/** 门店服务 */
+ (UIColor *)color_A0A0A0;

+ (UIColor *)color_DDDDDD;

+ (UIColor *)color_666666_86;

/** 退款页面 */
+ (UIColor *)color_FF5000;

+ (UIColor *)color_FF7C7C;

/** 会员颜色 */
+ (UIColor *)color_EE8636;

/** 渐变颜色 */
+ (UIColor *)color_FF4945;
+ (UIColor *)color_FF784B;

+ (UIColor *)color_FCE6E2;

+ (UIColor *)color_F9F9F9;

+ (UIColor *)color_FFCF7E;
+ (UIColor *)color_FFB154;

+ (UIColor *)color_FFE6D3;
+ (UIColor *)color_F4BF97;

+ (UIColor *)color_774510;
+ (UIColor *)color_CFA273;

+ (UIColor *)color_FF9C52;
+ (UIColor *)color_FF5A07;

+ (UIColor *)color_FF3A30;
+ (UIColor *)color_FE6B2E;

+ (UIColor *)color_FF9B0A;
+ (UIColor *)color_FF630B;

+ (UIColor *)color_FFD140;
+ (UIColor *)color_FF6E1C;


/** 滑动角标 */
+ (UIColor *)color_E6E6E6;
/** 分享 */
+ (UIColor *)color_EB5846;
/** 相册 */
+ (UIColor *)color_232323;

+ (UIColor *)color_F6F6F6;

+ (UIColor *)color_454545_9;

+ (UIColor *)color_E5E5E5;

+ (UIColor *)color_CBCBCB;

+ (UIColor *)color_FF641F;







@end
