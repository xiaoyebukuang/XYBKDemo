//
//  UIAlertViewTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 提示类－弹出警告框 */
@interface UIAlertViewTool : UIView

/**
 系统弹出窗（标题+详情+取消+确定）
 
 @param title 标题
 @param message 副标题
 @param alertBlock 回调
 */
+ (void)showTitle:(NSString *)title
          message:(NSString *)message
       alertBlock:(void(^)(NSString* mes, NSInteger index))alertBlock;

/**
 系统弹出窗（标题+详情+按钮标题）
 
 @param title 标题
 @param message 副标题
 @param titlesArr 按钮数组
 @param alertBlock 回调
 */
+ (void)showTitle:(NSString *)title
          message:(NSString *)message
        titlesArr:(NSArray *)titlesArr
       alertBlock:(void(^)(NSString *mes, NSInteger index))alertBlock;

/**
 系统弹出窗（标题+滑动详情+按钮标题）
 
 @param title 标题
 @param message 副标题
 @param titlesArr 按钮数组
 @param alertBlock 回调
 */
+ (void)showScrollTitle:(NSString *)title
                message:(NSString *)message
              titlesArr:(NSArray *)titlesArr
             alertBlock:(void(^)(NSString *mes, NSInteger index))alertBlock;

/**
 输入弹出窗（标题+输入框+按钮标题）
 
 @param title 标题
 @param placeHolder 输入框提示
 @param titlesArr 按钮数组
 @param alertBlock 回调
 */
+ (void)showFieldTitle:(NSString *)title
           placeHolder:(NSString *)placeHolder
             titlesArr:(NSArray *)titlesArr
            alertBlock:(void(^)(NSString *mes, NSInteger index))alertBlock;

/**
 自定义弹窗

 @param view 自定义view
 @param titlesArr 按钮标题
 @param alertBlock 回调
 */
+ (void)showView:(UIView *)view
       titlesArr:(NSArray *)titlesArr
      alertBlock:(void(^)(NSString *mes, NSInteger index))alertBlock;

@end
