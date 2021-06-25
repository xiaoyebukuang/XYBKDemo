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
/** 返回float型 */
+ (float)safe_towFloat:(id)obj {
    CGFloat number = [NSString safe_string:obj].floatValue;
    return round(number * 100)/100;
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
/** 业务相关，获取评价除去空格和换行符后的数据 */
+ (NSString *)getEvaluateStrWith:(NSString *)evaluateStr {
    NSString *content = [NSString safe_string:evaluateStr];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return content;
}

/** 获取uUTF8编码的str */
- (NSString *)getUTF8Str {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}
/** 获取字符串的宽度 */
- (CGFloat)getStrWidthWithFont:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width + 4;
}
- (CGFloat)getActualStrWidthWithFont:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
}
/** 获取字符串的高度 */
- (CGFloat)getStrHeightWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
}
/** 计算带有行间距的高度 */
- (CGFloat)getSpaceLabelHeightWithWidth:(CGFloat)width font:(UIFont *)font lineSpace:(NSInteger)linespace {
    CGSize textSize = CGSizeZero;
    // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    style.lineSpacing = linespace; // 设置行间距
    NSDictionary *attributes = @{ NSFontAttributeName :font, NSParagraphStyleAttributeName:style};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:opts attributes:attributes context:nil];
    textSize = rect.size;
    return textSize.height;
}
/** 查看联想的字段中带有搜索词的数组 */
+ (NSMutableArray*)calculateSubStringCount:(NSString *)content str:(NSString *)tab {
    int location = 0;
    NSMutableArray *locationArr = [NSMutableArray new];
    NSRange range = [content rangeOfString:tab];
    if (range.location == NSNotFound){
        return locationArr;
    }
    //声明一个临时字符串,记录截取之后的字符串
    NSString * subStr = content;
    while (range.location != NSNotFound) {
        if (location == 0) {
            location += range.location;
        } else {
            location += range.location + tab.length;
        }
        //记录位置
        NSNumber *number = [NSNumber numberWithUnsignedInteger:location];
        NSRange tagRange = NSMakeRange(number.integerValue, tab.length);
        [locationArr addObject:NSStringFromRange(tagRange)];
        //每次记录之后,把找到的字串截取掉
        subStr = [subStr substringFromIndex:range.location + range.length];
        range = [subStr rangeOfString:tab];
    }
    return locationArr;
}


/** 添加删除线 */
+ (NSMutableAttributedString *)orderPriceDeleteHandleWithStr:(NSString *)str {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSUInteger length = [str length];
    [attriStr addAttributes:@{ NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, length)];
    return attriStr;
}
+ (NSMutableAttributedString *)orderPriceDeleteHandleWithLeftStr:(NSString *)leftStr priceStr:(NSString *)priceStr {
    priceStr = [NSString safe_string:priceStr];
    if (priceStr.floatValue == 0) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    } else {
        NSString *str = [NSString stringWithFormat:@"%@%@",leftStr,priceStr];
        NSUInteger length = [str length];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attriStr addAttributes:@{ NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, length)];
        return attriStr;
    }
}
/** 获取NSMutableAttributedString(字体：左右) */
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
/** 获取NSMutableAttributedString(字体：左中右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                        leftFont:(UIFont *)leftFont
                                       centerStr:(NSString *)centerStr
                                      centerFont:(UIFont *)centerFont
                                        rightStr:(NSString *)rightStr
                                       rightFont:(UIFont *)rightFont {
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftStr,centerStr,rightStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange leftRange = {0 ,leftStr.length};
    NSRange centerRange = {leftStr.length, centerStr.length};
    NSRange rightRange = {leftStr.length + centerStr.length, rightStr.length};
    [attriStr addAttribute:NSFontAttributeName value:leftFont range:leftRange];
    [attriStr addAttribute:NSFontAttributeName value:centerFont range:centerRange];
    [attriStr addAttribute:NSFontAttributeName value:rightFont range:rightRange];
    return attriStr;
}
/** 获取NSMutableAttributedString(颜色：左右) */
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
/** 获取NSMutableAttributedString(颜色：左中右) */
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
/** 获取NSMutableAttributedString(颜色&字体：左右)  */
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
/** 获取NSMutableAttributedString(颜色:左中右，字体:左中右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        leftFont:(UIFont *)leftFont
                                       centerStr:(NSString *)centerStr
                                     centerColor:(UIColor *)centerColor
                                      centerFont:(UIFont *)centerFont
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor
                                       rightFont:(UIFont *)rightFont {
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftStr,centerStr,rightStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange leftRange = {0 ,leftStr.length};
    NSRange centerRange = {leftStr.length, centerStr.length};
    NSRange rightRange = {leftStr.length + centerStr.length, rightStr.length};
    [attriStr addAttribute:NSForegroundColorAttributeName value:leftColor range:leftRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:centerColor range:centerRange];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rightColor range:rightRange];
    
    [attriStr addAttribute:NSFontAttributeName value:leftFont range:leftRange];
    [attriStr addAttribute:NSFontAttributeName value:centerFont range:centerRange];
    [attriStr addAttribute:NSFontAttributeName value:rightFont range:rightRange];
    return attriStr;
}
/** 获取NSMutableAttributedString(颜色:左右，字体:左右) */
+ (NSMutableAttributedString *)getAttWithLeftStr:(NSString *)leftStr
                                       leftColor:(UIColor *)leftColor
                                        leftFont:(UIFont *)leftFont
                                        rightStr:(NSString *)rightStr
                                      rightColor:(UIColor *)rightColor
                                       rightFont:(UIFont *)rightFont {
    return [self getAttWithLeftStr:leftStr leftColor:leftColor leftFont:leftFont centerStr:@"" centerColor:[UIColor color_222222] centerFont:SYSTEM_FONT_12 rightStr:rightStr rightColor:rightColor rightFont:rightFont];
}
+ (NSString *)getDistanceDesWithDistance:(NSString *)distance {
    NSString *distanceStr;
    NSString *meterStr = [NSString safe_string:distance];
    if (meterStr.integerValue > 1000) {
        CGFloat floatKilometer = (CGFloat)meterStr.integerValue/1000;
        NSString *distanceStr01 = [NSString stringWithFormat:@"%.1f",floatKilometer];
        NSString *distanceStr02 = [NSString stringWithFormat:@"%.0f",floatKilometer];
        CGFloat sub = distanceStr01.floatValue - distanceStr02.floatValue;
        if (sub == 0) {
            distanceStr = [NSString stringWithFormat:@"%@km",distanceStr02];
        } else {
            distanceStr = [NSString stringWithFormat:@"%@km",distanceStr01];
        }
    } else {
        distanceStr = [NSString stringWithFormat:@"%@m",meterStr];
    }
    return distanceStr;
}
@end
