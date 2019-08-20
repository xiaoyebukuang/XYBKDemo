//
//  UIButton+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)
//TODO:标题
/** 创建button（标题） */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithTitle:title selectedTitle:nil titleColor:titleColor font:font];
}
/** 创建button（选中标题） */
+ (UIButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithTitle:title selectedTitle:selectdTitle titleColor:titleColor selectedTitleColor:nil font:font];
}
/** 创建button（选中标题+选中颜色）*/
+ (UIButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    if (selectdTitle) {
        [btn setTitle:selectdTitle forState:UIControlStateSelected];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (selectedTitleColor) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    btn.titleLabel.font = font;
    return btn;
}
/** 创建button (标题+禁用标题) */
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:normalColor font:font];
    [btn setTitleColor:disabledColor forState:UIControlStateDisabled];
    return btn;
}
//TODO:图标
/** 创建button（图标） */
+ (UIButton *)buttonWithImage:(NSString *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
/** 创建button（图标+选中图标） */
+ (UIButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return btn;
}
/** 创建button（图标+标题） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    return [self buttonWithImage:image title:title selectedTitle:nil titleColor:titleColor font:font];
}
/** 创建button（图标+选中标题） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title selectedTitle:selectdTitle titleColor:titleColor font:font];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
//TODO:背景
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
    return btn;
}
/** 创建button（背景+选中背景+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage selectBGImage:(NSString *)selectBGImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectBGImage] forState:UIControlStateSelected];
    return btn;
}



@end
