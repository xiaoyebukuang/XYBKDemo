//
//  MBProgressHUD+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MBProgressHUD+Helper.h"
typedef NS_ENUM(NSInteger, ProgressHUDType) {
    ProgressHUDTypeLoading,
    ProgressHUDTypeError,
    ProgressHUDTypeSuccess
};

@implementation MBProgressHUD (Helper)
#pragma mark 菊花加载
+ (void)showWindow {
    [self showToView:nil];
}
+ (void)showMessage:(NSString *)message {
    [self showMessage:message ToView:nil];
}
+ (void)showToView:(UIView *)view {
    [self showMessage:@"加载中..." ToView:view];
}
+ (void)showMessage:(NSString *)message ToView:(UIView *)view {
    [self showMessage:message ToView:view HUDType:ProgressHUDTypeLoading completeBlcok:nil];
}
#pragma mark -- 显示错误信息
+ (void)showError:(NSString *)error{
    [self showError:error ToView:nil];
}
+ (void)showError:(NSString *)error ToView:(UIView *)view{
    [self hideHUDForView:view];
    [self showMessage:error ToView:view HUDType:ProgressHUDTypeError completeBlcok:nil];
}
#pragma mark -- 显示正确信息
+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success ToView:nil];
}
+ (void)showSuccess:(NSString *)success completeBlcok:(MBProgressHUDCompletionBlock)completionBlock {
    [self showSuccess:success ToView:nil completeBlcok:completionBlock];
}
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view{
    [self showSuccess:success ToView:view completeBlcok:nil];
}
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view completeBlcok:(MBProgressHUDCompletionBlock)completionBlock {
    [self hideHUDForView:view];
    [self showMessage:success ToView:view HUDType:ProgressHUDTypeSuccess completeBlcok:completionBlock];
}
#pragma mark -- 构造
+ (void)showMessage:(NSString *)message ToView:(UIView *)view HUDType:(ProgressHUDType)HUDType completeBlcok:(MBProgressHUDCompletionBlock)completionBlock{
    if (view == nil) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    switch (HUDType) {
        case ProgressHUDTypeLoading:
            hud.mode = MBProgressHUDModeIndeterminate;
            break;
        case ProgressHUDTypeError:
            hud.mode = MBProgressHUDModeCustomView;
            //此处填写错误图标
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"request_error"]];
            [hud hideAnimated:YES afterDelay:1];
            break;
        case ProgressHUDTypeSuccess:
            hud.mode = MBProgressHUDModeCustomView;
            //此处填写成功图标
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"request_success"]];
            [hud hideAnimated:YES afterDelay:1];
            break;
    }
    if (completionBlock) {
        hud.completionBlock = completionBlock;
    }
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
}
#pragma mark -- 消失
+ (void)hideHUD{
    [self hideHUDForView:nil];
}
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) {
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    }
    [self hideHUDForView:view animated:YES];
}

@end
