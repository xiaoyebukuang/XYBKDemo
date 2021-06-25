
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
        case FormatCMd:
            return @"MM月dd日";
            break;
        case FormatYM:
            return @"yyyy年MM月";
        case FormatDDMd:
            return @"MM.dd";
            break;
    }
}
//TODO:dateStr
/** 获取指定格式的日期Str */
+ (NSString *)getDateStrWithDate:(NSDate *)date formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    NSString *dataStr = [dateFormatter stringFromDate:date];
    if (dataStr.length == 0) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",dataStr];
}
/** 获取今天指定格式的日期Str */
+ (NSString *)getTodayDateStrWithFormatType:(FormatType)type {
    return [self getDateStrWithDate:[NSDate date] formatType:type];
}
/** 获取指定格式的日期Str */
+ (NSString *)getDateStrWithDateStr:(NSString *)dateStr fromFormatType:(FormatType)fromFormatType toFormatType:(FormatType)toFormatType {
    NSDate *date = [self getDateWithDateStr:dateStr formatType:fromFormatType];
    return [self getDateStrWithDate:date formatType:toFormatType];
}
/** 将时间戳转换为日期Str */
+ (NSString *)getDateStrWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateStample];
    return [self getDateStrWithDate:date formatType:type];
}

//TODO:date
/** 将字符串转化为指定格式的日期 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr formatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return [dateFormatter dateFromString:dateStr];
}
/** 获取指定格式的日期date */
+ (NSDate *)getDateWithDate:(NSDate *)date formatType:(FormatType)type {
    NSString *dateStr = [self getDateStrWithDate:date formatType:type];
    return [self getDateWithDateStr:dateStr formatType:type];
}
/** 将时间戳转换为日期 */
+ (NSDate *)getDateWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateStample];
    return [self getDateWithDate:date formatType:type];
}
//TODO:距离
/** 获取距离时间second秒后的时间 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr afterSecond:(NSTimeInterval)second formatType:(FormatType)type {
    NSDate *currentDate = [self getDateWithDateStr:dateStr formatType:type];
    NSDate *theDate = [NSDate dateWithTimeInterval:second sinceDate:currentDate];
    return theDate;
}
/** 获取距离时间second秒后的时间 */
+ (NSDate *)getDateWithDate:(NSDate *)date afterSecond:(NSTimeInterval)second formatType:(FormatType)type {
    NSDate *theDate = [NSDate dateWithTimeInterval:second sinceDate:date];
    return [self getDateWithDate:theDate formatType:type];
}
/** 获取距离时间second秒后的时间 */
+ (NSString *)getDateStrWithDate:(NSDate *)date afterSecond:(NSTimeInterval)second formatType:(FormatType)type {
    NSDate *theDate = [NSDate dateWithTimeInterval:second sinceDate:date];
    return [self getDateStrWithDate:theDate formatType:type];
}
/** 获取时间戳 */
+ (NSTimeInterval)getDateStampleWithDate:(NSDate *)date {
    return [date timeIntervalSince1970]*1000;
}
/** 比较时间大小 */
+ (BOOL)compareOneDayStr:(NSString *)dayStr withAnotherDayStr:(NSString *)anotherDayStr formatType:(FormatType)type {
    NSDate *dateA = [self getDateWithDateStr:dayStr formatType:type];
    NSDate *dateB = [self getDateWithDateStr:anotherDayStr formatType:type];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedAscending) {
        return NO;
    } else {
        return YES;
    }
}
/** 比较时间大小 */
+ (BOOL)compareOneDay:(NSDate *)day withAnotherDay:(NSDate *)anotherDay {
    NSComparisonResult result = [day compare:anotherDay];
    if (result == NSOrderedAscending) {
        return NO;
    } else {
        return YES;
    }
}

//TODO:获取日历
+ (NSCalendar *)getCalendar {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    return calendar;
}
+ (NSDateFormatter *)getDateFormatterWithFormatType:(FormatType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:[NSDate getFormatType:type]];
    return dateFormatter;
}
/** 获取年月日时分秒星期*/
+ (NSDateComponents *)getCalendarDateWithDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    //年月日时分秒周
    NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute |NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    return dateComponent;
}
/** 获取日期 */
+ (NSDate *)getDateWithComponents:(NSDateComponents *)components {
    NSCalendar *calendar = [self getCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}
/** 获取年月日时分秒星期*/
+ (NSDateComponents *)getCalendarDateWithDateStr:(NSString *)dateStr formatType:(FormatType)type {
    NSDate *date = [self getDateWithDateStr:dateStr formatType:type];
    return [self getCalendarDateWithDate:date];
}
/** 获取星期 */
+ (NSString *)getActualWeekWithDate:(NSDate *)date {
    NSDateComponents *comps = [self getCalendarDateWithDate:date];
    NSString *week = @"";
    switch (comps.weekday) {
        case 1:week = @"周日";break;
        case 2:week = @"周一";break;
        case 3:week = @"周二";break;
        case 4:week = @"周三";break;
        case 5:week = @"周四";break;
        case 6:week = @"周五";break;
        case 7:week = @"周六";break;
        default:break;
    }
    return week;
}
/** 获取某月共有几天 */
+ (NSInteger)getTotaldaysInMonthWithDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    NSRange daysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInMonth.length;
}
/** 获取某月共有几周 */
+ (NSInteger)getTotalWeeksInMonthWithDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    NSRange weeksInMonth = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return weeksInMonth.length;
}
/** 获取今天/明天/后天/日期 */
+ (NSString *)getDayNameWithDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self getCalendarDateWithDate:date];
    if ([self isToday:date]) {
        return @"今天";
    }
    if ([self isTomorrow:date]) {
        return @"明天";
    }
    if ([self isAfterTomorrow:date]) {
        return @"后天";
    }
    return [NSString stringWithFormat:@"%d",(int)dateComponents.day];
}
+ (NSDateComponents *)getDifferDaysWithFromDate:(NSDate *)formDate toDate:(NSDate *)toDate {
    NSCalendar *calendar = [self getCalendar];
    formDate = [NSDate getDateWithDate:formDate formatType:FormatyyyyMd];
    toDate = [NSDate getDateWithDate:toDate formatType:FormatyyyyMd];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:formDate  toDate:toDate  options:0];
    return components;
}
/** 今天 */
+ (BOOL)isToday:(NSDate *)date {
    NSDateComponents *components = [self getDifferDaysWithFromDate:[NSDate date] toDate:date];
    if (components.day == 0 && components.month == 0 && components.year == 0) {
        return YES;
    }
    return NO;
}
/** 明天 */
+ (BOOL)isTomorrow:(NSDate *)date {
    NSDateComponents *components = [self getDifferDaysWithFromDate:[NSDate date] toDate:date];
    if (components.day == 1 && components.month == 0 && components.year == 0) {
        return YES;
    }
    return NO;
}
/** 后天 */
+ (BOOL)isAfterTomorrow:(NSDate *)date {
    NSDateComponents *components = [self getDifferDaysWithFromDate:[NSDate date] toDate:date];
    if (components.day == 2 && components.month == 0 && components.year == 0) {
        return YES;
    }
    return NO;
}
/** 获取日期期间的年月日 */
+ (NSArray *)getYearMonthDayWithStartDate:(NSString *)startDateStr endDate:(NSString *)endDateStr formatType:(FormatType)type {
    if (startDateStr.length == 0 || endDateStr.length == 0) {
        return @[];
    }
    NSCalendar *calendar = [self getCalendar];
    NSDate *startDate = [self getDateWithDateStr:startDateStr formatType:type];
    NSDate *endDate = [self getDateWithDateStr:endDateStr formatType:type];
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [startDate compare:endDate];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:startDate];
        [componentAarray addObject:[NSDate getDateStrWithDate:startDate formatType:FormatyyyyMd]];
        //后一天
        [comps setDay:([comps day]+1)];
        startDate = [calendar dateFromComponents:comps];
        //对比日期大小
        result = [startDate compare:endDate];
    }
    return componentAarray;
}
#pragma mark -- 业务
/** 截取 */
+ (NSString *)getTimeWithTime:(NSString *)time {
    NSString *dateTime = [NSString safe_string:time];
    if (dateTime.length > 3) {
        dateTime = [dateTime substringToIndex:dateTime.length - 3];
    }
    return dateTime;
}
@end
