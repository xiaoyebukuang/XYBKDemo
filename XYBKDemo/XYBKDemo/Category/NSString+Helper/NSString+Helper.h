//
//  NSString+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/** 返回安全的字符串 */
+ (NSString *)safe_string:(id)obj;

/** 保留两个小数 */
+ (NSString *)safe_twoDecimal:(id)obj;

/** 保留一个小数 */
+ (NSString *)safe_oneDecimal:(id)obj;

/** 返回float型 */
+ (float)safe_float:(id)obj;

/** 返回intefer型 */
+ (NSInteger)safe_integer:(id)obj;

/** 返回bool型 */
+ (BOOL)safe_bool:(id)obj;

/** 判断字符串是否为空 */
+ (BOOL)isEmpty:(id)obj;

/** 获取准确的数字字符串 */
+ (NSString *)safe_numStr:(id)obj;

/** 添加删除线 */
+ (NSMutableAttributedString *)orderPriceDeleteHandleWithStr:(NSString *)str;

/**
 获取NSMutableAttributedString(字体)
 
 @param leftStr 左边字体
 @param leftFont 左边字体font
 @param rightStr 右边字体
 @param rightFont 右边字体font
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                        leftFont:(UIFont *)leftFont
                                        rightStr:(NSString *)rightStr
                                       rightFont:(UIFont *)rightFont;


/**
 获取NSMutableAttributedString(颜色)
 
 @param leftStr 左边字体
 @param leftColor 左边字体Color
 @param rightStr 右边字体
 @param rightColor 右边字体Color
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor;

/** 获取字符串的宽度 */
- (CGFloat)getStrWidthWithFont:(UIFont *)font;
/** 获取字符串的高度 */
- (CGFloat)getStrHeightWithWidth:(CGFloat)width font:(UIFont *)font;

@end
