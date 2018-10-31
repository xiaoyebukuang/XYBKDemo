//
//  UIButton+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)
/**
 创建button（标题）
 
 @param title 标题
 @param titleColor 标题颜色
 @param font  标题大小
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font;

/**
 创建button（选中标题）

 @param title 标题
 @param selectdTitle 选中标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                selectedTitle:(NSString *)selectdTitle
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font;


/**
 创建button（选中标题+颜色）

 @param title 标题
 @param selectdTitle 选中标题
 @param titleColor 标题颜色
 @param selectedTitleColor 选中标题颜色
 @param font 字体大小
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                selectedTitle:(NSString *)selectdTitle
                   titleColor:(UIColor *)titleColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                         font:(UIFont *)font;

/**
 创建button（图标）
 
 @param image 图标
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image;

/**
 创建button（图标+标题）

 @param image 图标
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font;

/**
 创建button（图标+选中标题）
 
 @param image 图标
 @param title 标题
 @param selectdTitle 选中标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                        title:(NSString *)title
                selectedTitle:(NSString *)selectdTitle
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font;

/**
 创建button（背景）
 
 @param bgImage 背景
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage;


/**
 创建button（背景+标题）

 @param bgImage 背景
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font;

/**
 创建button（背景+选中标题）
 
 @param bgImage 背景
 @param title 标题
 @param selectdTitle 选中标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                          title:(NSString *)title
                  selectedTitle:(NSString *)selectdTitle
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font;


/**
 创建button（背景+图标+标题）

 @param bgImage 背景
 @param image 图标
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                          image:(NSString *)image
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font;

/**
 创建button（背景+选中背景+标题）
 
 @param bgImage 背景
 @param selectBGImage 选中背景
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font;












@end
