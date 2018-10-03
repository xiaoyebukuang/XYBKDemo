
//
//  NSDate+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)
+ (NSString *)getFormatType:(FormatType)type {
    switch (type) {
        case FormatDefault:
            return @"yyyy-MM-dd HH:mm:ss";
            break;
        case FormatyyyyMdHmsS:
            return @"yyyy-MM-dd HH:mm:ss.SSS";
            break;
        case FormatyyyyMdHm:
            return @"yyyy-MM-dd HH:mm";
            break;
        case FormatyyMdHm:
            return @"yy-MM-dd HH:mm";
            break;
        case FormatyyyyMd:
            return @"yyyy-MM-dd";
            break;
        case FormatyyyyM:
            return @"yyyy-MM";
            break;
        case FormatyyMd:
            return @"yy-MM-dd";
            break;
        case FormatMdHms:
            return @"MM-dd HH:mm:ss";
            break;
        case FormatMdHm:
            return @"MM-dd HH:mm";
            break;
        case FormatMd:
            return @"MM-dd";
            break;
        case FormatHms:
            return @"HH:mm:ss";
            break;
        case FormatHm:
            return @"HH:mm";
            break;
        case FormatYYYYMdHmsS:
            return @"yyyyMMddHHmmssSSS";
            break;
        case FormatYYYYMdHms:
            return @"yyyyMMddHHmmss";
            break;
        case FormatYYYYMd:
            return @"yyyyMMdd";
            break;
    }
}

/** 获取今天指定格式的日期Str */
+ (NSString *)getTodayDateStrWithFormatType:(FormatType)type {
    return [self getDateStrWithDate:[NSDate date] formatType:type];
}
/** 获取指定格式的日期Str */
+ (NSString *)getDateStrWithDate:(NSDate *)date formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return  [dateFormatter stringFromDate:date];
}
/** 将字符串转化为指定格式的日期 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return [dateFormatter dateFromString:dateStr];
}
/** 获取时间戳 */
+ (NSTimeInterval)getDateStampleWithDate:(NSDate *)date {
    return [date timeIntervalSince1970];
}
/** 将时间戳转换为日期 */
+ (NSDate *)getDateWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type {
    return [NSDate dateWithTimeIntervalSince1970:dateStample];
}
/** 将时间戳转换为日期Str */
+ (NSDate *)getDateStrWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateStample];
    return [self getDateStrWithDate:date formatType:type];
}
@end
