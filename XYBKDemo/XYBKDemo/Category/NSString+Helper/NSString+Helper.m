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
/** 获取准确的数字字符串 */
+ (NSString *)safe_numStr:(id)obj {
    NSString *number = [NSString safe_string:obj];
    
    NSDecimalNumber *number01 = [NSDecimalNumber decimalNumberWithString:number];
    NSLog(@"%@",number01.stringValue);
    NSString *numStr = [self safe_twoDecimal:obj];
    NSInteger decimal = (NSInteger)((numStr.floatValue - numStr.integerValue)*100);
    if (decimal > 0) {
        return numStr;
    } else {
        NSInteger num = numStr.integerValue;
        if (num == 0) {
            return @"";
        }
        return [NSString stringWithFormat:@"%ld",num];
    }
}



@end
