//
//  NSDecimalNumber+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2019/1/22.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "NSDecimalNumber+Helper.h"

@implementation NSDecimalNumber (Helper)
/** 减法 */
+ (NSString *)subtractingMinuend:(NSString *)minuend subtrahend:(NSString *)subtrahend {
    if (minuend.length == 0) {
        minuend = @"0";
    }
    if (subtrahend.length == 0) {
        subtrahend = @"0";
    }
    NSDecimalNumber *number01 = [NSDecimalNumber decimalNumberWithString:minuend];
    NSDecimalNumber *number02 = [NSDecimalNumber decimalNumberWithString:subtrahend];
    //相减
    NSDecimalNumber *subNmuber = [number01 decimalNumberBySubtracting:number02];
    if ([self getLessThanOrSameZeroWithNumber:subNmuber.stringValue]) {
        return @"0";
    }
    return subNmuber.stringValue;
}
/** 加法 */
+ (NSString *)additionAugend:(NSString *)augend addition:(NSString *)addition {
    if (augend.length == 0) {
        augend = @"0";
    }
    if (addition.length == 0) {
        addition = @"0";
    }
    NSDecimalNumber *number01 = [NSDecimalNumber decimalNumberWithString:augend];
    NSDecimalNumber *number02 = [NSDecimalNumber decimalNumberWithString:addition];
    //相加
    NSDecimalNumber *addNumer = [number01 decimalNumberByAdding:number02];
    return addNumer.stringValue;
}

/** 乘法 */
+ (NSString *)multiplyingMultiplier:(NSString *)multiplier otherMultiplier:(NSString *)otherMultiplier {
    if (multiplier.length == 0) {
        return @"0";
    }
    if (otherMultiplier.length == 0) {
        return @"0";
    }
    NSDecimalNumber *number01 = [NSDecimalNumber decimalNumberWithString:multiplier];
    NSDecimalNumber *number02 = [NSDecimalNumber decimalNumberWithString:otherMultiplier];
    //乘法
    NSDecimalNumber *number = [number01 decimalNumberByMultiplyingBy:number02];
    return [[NSString alloc]initWithFormat:@"%.2f",number.stringValue.floatValue];
}

/** 比较 */
+ (NSComparisonResult)compartWithNumber:(NSString *)number01 number:(NSString *)number02 {
    if (number01.length == 0) {
        number01 = @"0";
    }
    if (number02.length == 0) {
        number02 = @"0";
    }
    NSDecimalNumber *decimalNumber01 = [NSDecimalNumber decimalNumberWithString:number01];
    NSDecimalNumber *decimalNumber02 = [NSDecimalNumber decimalNumberWithString:number02];
    return [decimalNumber01 compare:decimalNumber02];
}
/** 是否小于0或等于0 */
+ (BOOL)getLessThanOrSameZeroWithNumber:(NSString *)number {
    if (number.length == 0) {
        number = @"0";
    }
    NSDecimalNumber *decimalNumber01 = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *decimalNumber02 = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSComparisonResult result = [decimalNumber01 compare:decimalNumber02];
    if (result != NSOrderedDescending) {
        return YES;
    }
    return NO;
}
@end
