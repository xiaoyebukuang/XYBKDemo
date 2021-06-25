//
//  UIButton+Function.m
//  cwz51
//
//  Created by 陈晓 on 2021/3/16.
//  Copyright © 2021 XYBK. All rights reserved.
//

#import "UIButton+Function.h"

@implementation UIButton (Function)
/** 橘色按钮 */
+ (UIButton *)functionCircularButtonWithTitle:(NSString *)title font:(UIFont *)font; {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor color_FF712C]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor color_FFFFFF] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addAllCircular];
    return button;
}
/** 底部长按钮 */
+ (UIButton *)functionButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = function_btn_long_height/2;
    [button setBackgroundColor:[UIColor color_FF712C]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor color_FFFFFF] forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEM_FONT_B_18;
    return button;
}
/** 右侧类似提交的按钮 */
+ (UIButton *)functionButtonWithSubmitTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = function_btn_submit_height/2;
    [button setBackgroundColor:[UIColor color_FF712C]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor color_FFFFFF] forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEM_FONT_16;
    return button;
}
- (void)changeStateSubmitBtnWithTitle:(NSString *)title isDisable:(BOOL)isDisable {
    [self setTitle:title forState:UIControlStateNormal];
    [self changeStateSubmitBtnWithIsDisable:isDisable];
}
- (void)changeStateSubmitBtnWithIsDisable:(BOOL)isDisable {
    if (isDisable) {
        self.userInteractionEnabled = NO;
        [self setBackgroundColor:[UIColor color_CCCCCC]];
    } else {
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor color_FF712C]];
    }
}
/** 退款类按钮 */
+ (UIButton *)functionButtonWithRefundTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = function_btn_refund_height/2.0;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor color_CCCCCC].CGColor;
    [button setBackgroundColor:[UIColor color_FFFFFF]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor color_222222] forState:UIControlStateNormal];
    button.titleLabel.font = SYSTEM_FONT_16;
    return button;
}
@end
