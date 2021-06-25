//
//  UIButton+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)

//TODO:title
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
 创建button（高亮标题颜色）
 
 @param title 标题
 @param titleColor 标题颜色
 @param highlightedColor 高亮标题
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
             highlightedColor:(UIColor *)highlightedColor
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
 创建button (标题+禁用标题)
 
 @param title 定时器标题
 @param font 字体大小
 @param normalColor 正常颜色
 @param disabledColor 禁用颜色
 @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                         font:(UIFont *)font
                  normalColor:(UIColor *)normalColor
                disabledColor:(UIColor *)disabledColor;

//TODO:image
/**
 创建button（图标）
 
 @param image 图标
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image;

/**
 创建button（图标+选中图标）
 
 @param image 图标
 @param selectedImage 选中图标
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage;

/**
 创建button（图标+禁用图标）

 @param image 图标
 @param disabledImage 禁用图标
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                disabledImage:(NSString *)disabledImage;

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
 创建button（图标+标题+是否需要偏移）
 
 @param image 图标
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
               needEdgeInsets:(BOOL)edgeInsets;

/**
 创建button（图标+标题+偏移多少）

 @param image 图标
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @param imageEdgeInsets 图片偏移
 @return button
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
              imageEdgeInsets:(CGFloat)imageEdgeInsets;

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

//TODO:BGImage
/**
 创建button（背景）
 
 @param bgImage 背景
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage;

/**
 创建button（背景+选中背景）

 @param bgImage 背景
 @param selectBGImage 选中背景
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage;

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

+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                          image:(NSString *)image
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font
                        isInset:(BOOL)isInset;

/**
 创建button（背景+选中背景+选中标题颜色）
 
 @param bgImage 背景
 @param selectBGImage 选中背景
 @param title 标题
 @param titleColor 标题颜色
 @param selectedTitleColor 选中标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
             selectedTitleColor:(UIColor *)selectedTitleColor
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

/**
 创建button（背景+禁用背景+标题）

 @param bgImage 背景
 @param disabledBGImage 禁用背景
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                disabledBGImage:(NSString *)disabledBGImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font;

/**
 创建button（背景+选中背景+图标+标题）
 
 @param bgImage 背景
 @param selectBGImage 选中背景
 @param image 图标
 @param title 标题
 @param titleColor 标题颜色
 @param font 标题大小
 @return button
 */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage
                          image:(NSString *)image
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font;

/**
 创建button（订单timer专用）
 */
+ (UIButton *)buttonWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)selectedColor
                         font:(UIFont *)font;

@end
