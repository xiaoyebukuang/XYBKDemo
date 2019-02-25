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
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone6系列
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define IS_IPHONE_6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

/** 屏幕 rect */
#define MAIN_SCREEN_BOUNDS      ([UIScreen mainScreen].bounds)
#define MAIN_SCREEN_WIDTH       ([UIScreen mainScreen].bounds.size.width)
#define MAIN_SCREEN_HEIGHT      ([UIScreen mainScreen].bounds.size.height)


#define IPHONEX_MORE_Xr \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define IPHONEX_MORE            (IS_IPHONE_X || IPHONEX_MORE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)

/** iPhoneX顶部多余高度 */
#define IPHONEX_TOP_HEIGHT      (IPHONEX_MORE ? 24.f : 0.f)
/** iPhoneX底部多余高度 */
#define IPHONEX_BOTTOW_HEIGHT   (IPHONEX_MORE ? 34.f : 0.f)
/** 状态栏高度 */
#define NAV_STA_HEIGHT          (IPHONEX_TOP_HEIGHT + 20)
/** 导航栏高度 */
#define NAV_BAR_HEIGHT          (NAV_STA_HEIGHT + 44)
/** TABBAR高度 */
#define TAB_BAR_HEIGHT          (IPHONEX_BOTTOW_HEIGHT + 49)
/** 导航栏可视高度 */
#define NAV_CONTENT_HEIGHT      (MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT)
/** 导航栏TABBAR可视高度 */
#define NAV_TAB_CONTENT_HEIGHT  (MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)
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
