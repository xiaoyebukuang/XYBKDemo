//
//  MBProgressHUD+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Helper)
/**
 菊花提示，不自动消失
 */
+ (void)showWindow;

/**
 菊花提示，不自动消失
 
 @param message 要显示的文字
 */
+ (void)showMessage:(NSString *)message;
/**
 菊花提示，不自动消失
 @param view 要添加的view
 */
+ (void)showToView:(UIView *)view;

/**
 文字+菊花提示,不自动消失
 @param message 要显示的文字
 @param view    要添加的View
 */
+ (void)showMessage:(NSString *)message ToView:(UIView *)view;

/**
 自动消失错误提示，带默认图
 @param error 错误提示语
 */
+ (void)showError:(NSString *)error;

/**
 自动消失错误提示,带默认图
 @param error 错误提示语
 @param view  要添加的View
 */
+ (void)showError:(NSString *)error ToView:(UIView *)view;

/**
 自动消失成功提示，带默认图，加载到window上
 @param success 成功提示语
 */
+ (void)showSuccess:(NSString *)success;

/**
 自动消失成功提示，带默认图
 @param success 成功提示语
 @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view;

/**
 快速从window中隐藏ProgressView
 */
+ (void)hideHUD;

/**
 隐藏ProgressView
 @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;
@end
