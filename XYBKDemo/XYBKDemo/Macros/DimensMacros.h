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
#define NAV_TOP_HEIGHT          (IS_IPHONE_X ? 24.f : 0.f)
/** iPhoneX底部多余高度 */
#define NAV_BOTTOW_HEIGHT       (IS_IPHONE_X ? 34.f : 0.f)
/** 状态栏高度 */
#define NAV_STA_HEIGHT          (NAV_TOP_HEIGHT + 20)
/** 导航栏高度 */
#define NAV_BAR_HEIGHT          (NAV_TOP_HEIGHT + 44)
/** TABBAR高度 */
#define NAV_TABBAR_HEIGHT       (NAV_BOTTOW_HEIGHT + 49)
/** 可视图区域 */
#define NAV_CONTENT_HEIGHT      (MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT - NAV_TABBAR_HEIGHT)
/** 横向适配比例 */
#define WIDTH_ADAPTER(x)        ceilf((x) * (MAIN_SCREEN_WIDTH / 375.0))
/** 纵向适配比例 */
#define HEIGHT_ADAPTER(y)       ceilf((y) * (MAIN_SCREEN_HEIGHT / 667.0))

#endif /* DimensMacros_h */
