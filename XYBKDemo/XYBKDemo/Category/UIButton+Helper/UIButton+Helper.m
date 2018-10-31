//
//  UIButton+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)
/** 创建button（标题） */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}
/** 创建button（选中标题） */
+ (UIButton *)buttonWithTitle:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    if (selectdTitle) {
        [btn setTitle:selectdTitle forState:UIControlStateSelected];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}
/** 创建button（选中标题+颜色） */
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
/** 创建button（图标） */
+ (UIButton *)buttonWithImage:(NSString *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}

/** 创建button（图标+标题） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}
/** 创建button（图标+选中标题） */
+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    if (selectdTitle) {
        [btn setTitle:selectdTitle forState:UIControlStateSelected];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}
/** 创建button（背景）*/
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    return btn;
}
/** 创建button（背景+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

/** 创建button（背景+选中标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage title:(NSString *)title selectedTitle:(NSString *)selectdTitle titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    if (selectdTitle) {
        [btn setTitle:selectdTitle forState:UIControlStateSelected];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

/** 创建button（背景+图标+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage image:(NSString *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    return btn;
}

/** 创建button（背景+选中背景+标题） */
+ (UIButton *)buttonWithBGImage:(NSString *)bgImage selectBGImage:(NSString *)selectBGImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectBGImage] forState:UIControlStateSelected];
    return btn;
}



@end
