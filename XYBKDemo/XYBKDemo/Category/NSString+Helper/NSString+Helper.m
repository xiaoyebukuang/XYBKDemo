//
//  NSString+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)
/** 返回安全的字符串 */
+ (NSString *)safe_string:(id)obj {
    if ([obj isEqual:[NSNull null]]||obj == nil) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",obj];
    }
}
/** 保留两个小数 */
+ (NSString *)safe_twoDecimal:(id)obj {
    return [NSString stringWithFormat:@"%.2f",[self safe_float:obj]];
}
/** 保留一个小数 */
+ (NSString *)safe_oneDecimal:(id)obj {
    return [NSString stringWithFormat:@"%.1f",[self safe_float:obj]];
}
/** 返回float型 */
+ (float)safe_float:(id)obj {
    return [NSString safe_string:obj].floatValue;
}
/** 返回intefer型 */
+ (NSInteger)safe_integer:(id)obj {
    return [NSString safe_string:obj].integerValue;
}
/** 返回int型 */
+ (int)safe_int:(id)obj {
    return [NSString safe_string:obj].intValue;
}
/** 返回bool型 */
+ (BOOL)safe_bool:(id)obj {
    return [NSString safe_string:obj].boolValue;
}
/** 判断字符串是否为空 */
+ (BOOL)isEmpty:(id)obj {
    if (obj == nil) {
        return YES;
    }
    if ([[NSString safe_string:obj] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
/** 获取准确的数字字符串 */
+ (NSString *)safe_numStr:(id)obj {
    NSString *number = [NSString safe_string:obj];
    if (number.length == 0) {
        return @"0";
    }
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:number];
    NSString *numberStr = decimalNumber.stringValue;
    return numberStr;
}

/** 添加删除线 */
+ (NSMutableAttributedString *)getAttDeleteHandleWithStr:(NSString *)str {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSUInteger length = [str length];
    [attriStr addAttributes:@{ NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, length)];
    return attriStr;
}
/** 获取NSMutableAttributedString(字体) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                        leftFont:(UIFont *)leftFont
                                        rightStr:(NSString *)rightStr
                                       rightFont:(UIFont *)rightFont {
    NSString *str = [NSString stringWithFormat:@"%@%@",leftStr,rightStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange leftRange = {0 ,leftStr.length};
    NSRange rightRange = {leftStr.length, rightStr.length};
    [attriStr addAttribute:NSFontAttributeName value:leftFont range:leftRange];
    [attriStr addAttribute:NSFontAttributeName value:rightFont range:rightRange];
    return attriStr;
}
/** 获取NSMutableAttributedString(颜色) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor {
    NSString *str = [NSString stringWithFormat:@"%@%@",leftStr,rightStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange leftRange = {0 ,leftStr.length};
    NSRange rightRange = {leftStr.length, rightStr.length};
    [attriStr addAttribute:NSForegroundColorAttributeName value:leftColor range:leftRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rightColor range:rightRange];
    return attriStr;
}
/** 获取NSMutableAttributedString(颜色) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                       centerStr:(NSString *)centerStr
                                     centerColor:(UIColor *)centerColor
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor {
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftStr,centerStr,rightStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange leftRange = {0 ,leftStr.length};
    NSRange centerRange = {leftStr.length, centerStr.length};
    NSRange rightRange = {leftStr.length + centerStr.length, rightStr.length};
    [attriStr addAttribute:NSForegroundColorAttributeName value:leftColor range:leftRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:centerColor range:centerRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rightColor range:rightRange];
    return attriStr;
}
/** 获取NSMutableAttributedString(颜色 + 字体) 注：leftColorStr+rightColorStr = leftFontStr+rightFontStr */
+ (NSMutableAttributedString *)getAttWithLeftColorStr:(NSString *)leftColorStr
                                            leftColor:(UIColor *)leftColor
                                        rightColorStr:(NSString *)rightColorStr
                                           rightColor:(UIColor *)rightColor
                                          leftFontStr:(NSString *)leftFontStr
                                             leftFont:(UIFont *)leftFont
                                         rightFontStr:(NSString *)rightFontStr
                                            rightFont:(UIFont *)rightFont {
    NSString *text = [NSString stringWithFormat:@"%@%@",leftColorStr,rightColorStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSRange leftColorRange = {0 ,leftColorStr.length};
    NSRange rightColorRange = {leftColorStr.length, rightColorStr.length};
    [attriStr addAttribute:NSForegroundColorAttributeName value:leftColor range:leftColorRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rightColor range:rightColorRange];
    
    NSRange leftFontRange = {0 ,leftFontStr.length};
    NSRange rightFontRange = {leftFontStr.length, rightFontStr.length};
    [attriStr addAttribute:NSFontAttributeName value:leftFont range:leftFontRange];
    [attriStr addAttribute:NSFontAttributeName value:rightFont range:rightFontRange];
    return attriStr;
}

//TODO:字符宽度&高度
/** 获取字符串的宽度 */
- (CGFloat)getStrWidthWithFont:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
}
/** 获取字符串的高度 */
- (CGFloat)getStrHeightWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

@end
