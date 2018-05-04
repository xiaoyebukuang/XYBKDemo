//
//  UIAlertViewTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIAlertViewTool.h"

@implementation UIAlertViewTool

+ (void)showAlertViewControllerWithTitle:(NSString *)title withAlertMessage:(NSString *)message withViewController:(UIViewController *)viewController withCompletionBlock:(void (^)(void))block {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alertCtrl addAction:cancelAction];
    //确定
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (block) {
            block();
        }
    }];
    [alertCtrl addAction:okAction];
    [viewController presentViewController:alertCtrl animated:YES completion:nil];
}

@end
