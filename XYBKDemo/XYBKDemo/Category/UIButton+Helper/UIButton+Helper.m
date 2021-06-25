//
//  UIButton+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIButton+Helper.h"
const static CGFloat ImageEdgeInsets  = -15;
@implementation UIButton (Helper)
/** 创建button（标题） */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithTitle:title selectedTitle:nil titleColor:titleColor font:font];
}
/** 创建button（选中标题） */
+ (UIButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithTitle:title selectedTitle:selectdTitle titleColor:titleColor selectedTitleColor:nil font:font];
}
/** 创建button（高亮标题颜色） */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightedColor:(UIColor *)highlightedColor font:(UIFont *)font {
    UIButton *btn = [self buttonWithTitle:title titleColor:titleColor font:font];
    [btn setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    return btn;
}
/** 创建button（选中标题+颜色） */
+ (UIButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (selectdTitle) {
        [btn setTitle:selectdTitle forState:UIControlStateSelected];
    }
    if (selectedTitleColor) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    return btn;
}
/** 创建button (标题+禁用标题)） */
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:disabledColor forState:UIControlStateDisabled];
    return btn;
}
/** 创建button（图标） */
+ (UIButton *)buttonWithImage:(NSString *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
/** 创建button（图标+选中图标） */
+ (UIButton *)buttonWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return btn;
}
/** 创建button（图标+禁用图标）*/
+ (UIButton *)buttonWithImage:(NSString *)image disabledImage:(NSString *)disabledImage {
   UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:disabledImage] forState:UIControlStateDisabled];
    return btn;
}

/** 创建button（图标+标题） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithImage:image title:title selectedTitle:nil titleColor:titleColor font:font];
}
/** 创建button（图标+标题+是否需要偏移） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font needEdgeInsets:(BOOL)edgeInsets {
    UIButton *btn = [self buttonWithImage:image title:title selectedTitle:nil titleColor:titleColor font:font];
    if (edgeInsets) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, ImageEdgeInsets, 0, 0)];
    }
    return btn;
}
/** 创建button（图标+标题+偏移多少） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageEdgeInsets:(CGFloat)imageEdgeInsets {
    UIButton *btn = [self buttonWithImage:image title:title titleColor:titleColor font:font];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -imageEdgeInsets, 0, 0)];
    return btn;
}
/** 创建button（图标+选中标题） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title selectedTitle:selectdTitle titleColor:titleColor font:font];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
/** 创建button（背景）*/
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    return btn;
}
/** 创建button（背景+选中背景） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage selectBGImage:(NSString *)selectBGImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectBGImage] forState:UIControlStateSelected];
    return btn;
}
/** 创建button（背景+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithBGImage:bgImage title:title selectedTitle:nil titleColor:titleColor font:font];
}

/** 创建button（背景+选中标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage title:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title selectedTitle:selectdTitle titleColor:titleColor font:font];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    return btn;
}

/** 创建button（背景+图标+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage image:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, ImageEdgeInsets, 0, 0)];
    return btn;
}
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage image:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font isInset:(BOOL)isInset {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    if (isInset) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, ImageEdgeInsets, 0, 0)];
    }
    return btn;
}
/** 创建button（背景+选中背景+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectBGImage] forState:UIControlStateSelected];
    return btn;
}
/** 创建button（背景+禁用背景+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                disabledBGImage:(NSString *)disabledBGImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disabledBGImage] forState:UIControlStateDisabled];
    return btn;
}
/** 创建button（背景+选中背景+选中标题颜色） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
             selectedTitleColor:(UIColor *)selectedTitleColor
                           font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectBGImage] forState:UIControlStateSelected];
    return btn;
}
/** 创建button（背景+选中背景+图标+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage
                  selectBGImage:(NSString *)selectBGImage
                          image:(NSString *)image
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                           font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithBGImage:bgImage selectBGImage:selectBGImage title:title titleColor:titleColor font:font];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, ImageEdgeInsets, 0, 0)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}

/** 创建button（订单timer专用）*/
+ (UIButton *)buttonWithImage:(NSString *)image
                selectedImage:(NSString *)selectedImage
                        title:(NSString *)title
                selectedTitle:(NSString *)selectedTitle
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)selectedColor
                         font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return btn;
}
@end
