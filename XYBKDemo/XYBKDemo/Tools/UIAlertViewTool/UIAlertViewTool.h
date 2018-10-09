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
       alertBlock:(void(^)(NSInteger index))alertBlock;
@end
