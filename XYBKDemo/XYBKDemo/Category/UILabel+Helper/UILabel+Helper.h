//
//  UILabel+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)
/**
 创建UILabel

 @param textColor 标题颜色
 @param font 标题大小
 @return label
 */
- (instancetype)initWithTextColor:(UIColor *)textColor
                             font:(UIFont *)font;


/**
 创建UILabel

 @param text 标题
 @param textColor 标题颜色
 @param font 标题大小
 @return label
 */
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                        font:(UIFont *)font;

/**
 创建UILabel
 
 @param textColor 标题颜色
 @param textAlignment 排版方式
 @param font 标题大小
 @return label
 */
- (instancetype)initWithTextColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)textAlignment
                             font:(UIFont *)font;

/**
 创建UILabel
 
 @param text 标题
 @param textColor 标题颜色
 @param textAlignment 排版方式
 @param font 标题大小
 @return label
 */
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment
                        font:(UIFont *)font;

/**
 创建UILabel
 
 @param text 标题
 @param textColor 标题颜色
 @param textAlignment 排版方式
 @param font 标题大小
 @param lineSpacing 行间距
 @return label
 */
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment
                        font:(UIFont *)font
                 lineSpacing:(CGFloat)lineSpacing;

@end
