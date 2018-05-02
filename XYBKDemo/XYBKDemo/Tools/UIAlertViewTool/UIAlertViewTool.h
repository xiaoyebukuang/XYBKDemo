//
//  UIAlertViewTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 提示类－弹出警告框 */
@interface UIAlertViewTool : NSObject

/**
 系统弹出框(确定，取消)

 @param title 标题
 @param message 副标题
 @param viewController 跳转视图
 @param block 点击确定按钮回调
 */
+ (void)showAlertViewControllerWithTitle:(NSString *)title withAlertMessage:(NSString *)message withViewController:(UIViewController *)viewController withCompletionBlock:(void(^)(void))block;




@end
