//
//  DimensMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h


/** iphone判断 */
#define IS_IPHONE_4         (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5         (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6         (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS    (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_IPHONE_X         ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen]currentMode].size) :NO)
/** 屏幕 rect */
#define MAIN_SCREEN_BOUNDS      ([UIScreen mainScreen].bounds)
#define MAIN_SCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)
#define MAIN_SCREEN_HEIGHT      ([UIScreen mainScreen].bounds.size.height)
/** iPhoneX顶部多余高度 */
#define IPHONEX_TOP_HEIGHT      (IS_IPHONE_X ? 24.f : 0.f)
/** iPhoneX底部多余高度 */
#define IPHONEX_BOTTOW_HEIGHT   (IS_IPHONE_X ? 34.f : 0.f)
/** 状态栏高度 */
#define NAV_STA_HEIGHT          (IPHONEX_TOP_HEIGHT + 20)
/** 导航栏高度 */
#define NAV_BAR_HEIGHT          (NAV_STA_HEIGHT + 44)
/** TABBAR高度 */
#define TAB_BAR_HEIGHT          (IPHONEX_BOTTOW_HEIGHT + 49)
/** 导航栏可视高度 */
#define NAV_CONTENT_HEIGHT      (MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT)
/** 导航栏TABBAR可视高度 */
#define NAV_TAB_CONTENT_HEIGHT      (MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)
/** 横向适配比例 */
#define WIDTH_ADAPTER(x)        ceilf((x) * (MAIN_SCREEN_WIDTH / 375.0))
/** 纵向适配比例 */
#define HEIGHT_ADAPTER(y)       ceilf((y) * (MAIN_SCREEN_HEIGHT / 667.0))


#define kApplication            [UIApplication sharedApplication]
/** 取appDelegate */
#define kApplicationDelegate    (AppDelegate *)[UIApplication sharedApplication].delegate
/** 获取appDelegate的window */
#define kAppDelegateWindow      [UIApplication sharedApplication].delegate.window
/** 获取keyWindow */
#define kKeyWindow              [UIApplication sharedApplication].keyWindow
/** 获取本地存储 */
#define kUserDefaults           [NSUserDefaults standardUserDefaults]
/** 获取通知 */
#define kNotificationCenter     [NSNotificationCenter defaultCenter]


#endif /* DimensMacros_h */
