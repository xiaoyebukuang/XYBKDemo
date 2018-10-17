//
//  MBProgressHUD+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Helper)
//TODO: 刷新
/**
 菊花提示，加载到window上，不自动消失
 */
+ (void)showWindow;

/**
 菊花提示，加载到window上，不自动消失
 
 @param message 要显示的文字
 */
+ (void)showMessage:(NSString *)message;

/**
 菊花提示，加载到指定view上，不自动消失
 @param view 要添加的view
 */
+ (void)showToView:(UIView *)view;

/**
 文字+菊花提示，加载到指定view上，不自动消失
 @param message 要显示的文字
 @param view    要添加的View
 */
+ (void)showMessage:(NSString *)message ToView:(UIView *)view;

//TODO: 错误提示
/**
 错误提示，加载到window上，自动消失
 @param error 错误提示语
 */
+ (void)showError:(NSString *)error;

/**
 错误提示，加载到window上，自动消失，消失回调
 
 @param error 错误提示语
 @param completionBlock 消失回调
 */
+ (void)showError:(NSString *)error completeBlcok:(MBProgressHUDCompletionBlock)completionBlock;

/**
 错误提示，加载到自定view上，自动消失
 @param error 错误提示语
 @param view  要添加的View
 */
+ (void)showError:(NSString *)error ToView:(UIView *)view;

/**
 错误提示，加载到自定view上，自动消失，消失回调

 @param error 错误提示语
 @param view 要添加的View
 @param completionBlock 回调
 */
+ (void)showError:(NSString *)error ToView:(UIView *)view completeBlcok:(MBProgressHUDCompletionBlock)completionBlock;

//TODO: 成功提示
/**
 成功提示，加载到window上，自动消失
 @param success 成功提示语
 */
+ (void)showSuccess:(NSString *)success;

/**
 成功提示，加载到window上，自动消失，消失回调

 @param success 成功提示语
 @param completionBlock 消失回调
 */
+ (void)showSuccess:(NSString *)success completeBlcok:(MBProgressHUDCompletionBlock)completionBlock;

/**
 成功提示，加载到指定view上，自动消失
 @param success 成功提示语
 @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view;

/**
 成功提示，加载到指定view上，自动消失，消失回调

 @param success 成功提示语
 @param view 要添加的view
 @param completionBlock 回调
 */
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view completeBlcok:(MBProgressHUDCompletionBlock)completionBlock;

//TODO: 移除
/**
 从window中移除
 */
+ (void)hideHUD;

/**
 从指定view中移除
 @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;
@end
