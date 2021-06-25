//
//  NSDecimalNumber+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2019/1/22.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Helper)

/**
 减法
 @param minuend 被减数
 @param subtrahend 减数
 @return 返回
 */
+ (NSString *)subtractingMinuend:(NSString *)minuend subtrahend:(NSString *)subtrahend;

/**
 加法
 @param augend 被加数
 @param addition 加数
 @return 返回
 */
+ (NSString *)additionAugend:(NSString *)augend addition:(NSString *)addition;

/**
 乘法
 @param multiplier 乘数
 @param otherMultiplier 被乘数
 @return 返回
 */
+ (NSString *)multiplyingMultiplier:(NSString *)multiplier otherMultiplier:(NSString *)otherMultiplier;

/**
 比较大小
 @param number01 比较数
 @param number02 比较数
 @return NSOrderedAscending 小于 // NSOrderedSame 相等 // NSOrderedDescending 大于
 */
+ (NSComparisonResult)compartWithNumber:(NSString *)number01 number:(NSString *)number02;


/**
 是否小于0或等于0

 @param number 比较数
 @return 是否小于0
 */
+ (BOOL)getLessThanOrSameZeroWithNumber:(NSString *)number;


@end
