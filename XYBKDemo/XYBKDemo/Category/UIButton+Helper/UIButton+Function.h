//
//  UIButton+Function.h
//  cwz51
//
//  Created by 陈晓 on 2021/3/16.
//  Copyright © 2021 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 底部长按钮 */
static const CGFloat function_btn_long_height = 44;

/** 右侧类似提交的按钮 */
static const CGFloat function_btn_submit_height = 40;

static const CGFloat function_btn_submit_width = 130;

/** 退款类按钮 */
static const CGFloat function_btn_refund_height = 35;

static const CGFloat function_btn_refund_width = 90;


@interface UIButton (Function)

/** 橘色按钮 */
+ (UIButton *)functionCircularButtonWithTitle:(NSString *)title font:(UIFont *)font;

/** 底部长按钮 */
+ (UIButton *)functionButtonWithTitle:(NSString *)title;

/** 右侧类似提交的按钮 */
+ (UIButton *)functionButtonWithSubmitTitle:(NSString *)title;
/** 更改状态 */
- (void)changeStateSubmitBtnWithTitle:(NSString *)title isDisable:(BOOL)isDisable;
- (void)changeStateSubmitBtnWithIsDisable:(BOOL)isDisable;

/** 退款类按钮 */
+ (UIButton *)functionButtonWithRefundTitle:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
