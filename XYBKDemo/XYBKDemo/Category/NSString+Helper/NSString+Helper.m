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
/** 验证手机号码及固定电话 */
+ (BOOL)validatePhoneNumber:(NSString *)mobileNum {
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSString *phoneRegex2=@"^1(47[0-9])\\d{7}$";
    NSPredicate *phoneTest2=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex2];
    return [phoneTest evaluateWithObject:mobileNum]|[phoneTest2 evaluateWithObject:mobileNum];
}



@end
