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

/** 返回float型 */
+ (float)safe_towFloat:(id)obj;

/** 返回intefer型 */
+ (NSInteger)safe_integer:(id)obj;

/** 返回int型 */
+ (int)safe_int:(id)obj;

/** 返回bool型 */
+ (BOOL)safe_bool:(id)obj;

/** 判断字符串是否为空 */
+ (BOOL)isEmpty:(id)obj;

/** 获取准确的数字字符串 */
+ (NSString *)safe_numStr:(id)obj;


/** 业务相关，获取评价除去空格和换行符后的数据 */
+ (NSString *)getEvaluateStrWith:(NSString *)evaluateStr;


/** 获取uUTF8编码的str */
- (NSString *)getUTF8Str;
/** 获取字符串的宽度 */
- (CGFloat)getStrWidthWithFont:(UIFont *)font;

- (CGFloat)getActualStrWidthWithFont:(UIFont *)font;
/** 获取字符串的高度 */
- (CGFloat)getStrHeightWithWidth:(CGFloat)width font:(UIFont *)font;
/** 计算带有行间距的高度 */
- (CGFloat)getSpaceLabelHeightWithWidth:(CGFloat)width font:(UIFont *)font lineSpace:(NSInteger)linespace;



/** 查看联想的字段中带有搜索词的数组<NSString<NSRange格式>> */
+ (NSMutableArray*)calculateSubStringCount:(NSString *)content str:(NSString *)tab;
/** 添加删除线 */
+ (NSMutableAttributedString *)orderPriceDeleteHandleWithStr:(NSString *)str;
+ (NSMutableAttributedString *)orderPriceDeleteHandleWithLeftStr:(NSString *)leftStr priceStr:(NSString *)priceStr;

/**
 获取NSMutableAttributedString(字体:左右)
 */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                        leftFont:(UIFont *)leftFont
                                        rightStr:(NSString *)rightStr
                                       rightFont:(UIFont *)rightFont;

/** 获取NSMutableAttributedString(字体：左中右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                        leftFont:(UIFont *)leftFont
                                       centerStr:(NSString *)centerStr
                                      centerFont:(UIFont *)centerFont
                                        rightStr:(NSString *)rightStr
                                       rightFont:(UIFont *)rightFont;

/** 获取NSMutableAttributedString(颜色:左右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor;

/** 获取NSMutableAttributedString(颜色:左中右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                       centerStr:(NSString *)centerStr
                                     centerColor:(UIColor *)centerColor
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor;

/** 获取NSMutableAttributedString(颜色 + 字体:左右) 注：leftColorStr+rightColorStr = leftFontStr+rightFontStr */
+ (NSMutableAttributedString *)getAttWithLeftColorStr:(NSString *)leftColorStr
                                            leftColor:(UIColor *)leftColor
                                        rightColorStr:(NSString *)rightColorStr
                                           rightColor:(UIColor *)rightColor
                                          leftFontStr:(NSString *)leftFontStr
                                             leftFont:(UIFont *)leftFont
                                         rightFontStr:(NSString *)rightFontStr
                                            rightFont:(UIFont *)rightFont;


/** 获取NSMutableAttributedString(颜色:左中右，字体:左中右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        leftFont:(UIFont *)leftFont
                                       centerStr:(NSString *)centerStr
                                     centerColor:(UIColor *)centerColor
                                      centerFont:(UIFont *)centerFont
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor
                                       rightFont:(UIFont *)rightFont;

/** 获取NSMutableAttributedString(颜色:左右，字体:左右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        leftFont:(UIFont *)leftFont
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor
                                       rightFont:(UIFont *)rightFont;

+ (NSString *)getDistanceDesWithDistance:(NSString *)distance;


@end
