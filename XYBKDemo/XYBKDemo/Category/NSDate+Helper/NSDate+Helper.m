
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

+ (NSString *)getTodayDateStringFormatType:(FormatType)type {
    return [self getDateString:[NSDate date] formatType:type];
}

+ (NSString *)getDateString:(NSDate *)date formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return  [dateFormatter stringFromDate:date];
}

+ (NSDate *)getDate:(NSString *)dateStr formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return [dateFormatter dateFromString:dateStr];
}

@end
