//
//  NSDate+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, FormatType) {
    FormatDefault,          //yyyy-MM-dd HH:mm:ss
    FormatyyyyMdHmsS,       //yyyy-MM-dd HH:mm:ss.SSS
    FormatyyyyMdHm,         //yyyy-MM-dd HH:mm
    FormatyyMdHm,           //yy-MM-dd HH:mm
    FormatyyyyMd,           //yyyy-MM-dd
    FormatyyyyM,            //yyyy-MM
    FormatyyMd,             //yy-MM-dd
    FormatMdHms,            //MM-dd HH:mm:ss
    FormatMdHm,             //MM-dd HH:mm
    FormatMd,               //MM-dd
    FormatHms,              //HH:mm:ss
    FormatHm,               //HH:mm
    FormatYYYYMdHmsS,       //yyyyMMddHHmmssSSS
    FormatYYYYMdHms,        //yyyyMMddHHmmss
    FormatYYYYMd,           //yyyyMMdd
};
@interface NSDate (Helper)

//TODO:获取dateStr
/**
 获取今天指定格式的日期Str
 @param type 格式
 @return dateStr
 */
+ (NSString *)getTodayDateStrWithFormatType:(FormatType)type;

/**
 获取指定格式的日期Str
 @param date 日期
 @param type 日期类型
 @return dateStr
 */
+ (NSString *)getDateStrWithDate:(NSDate *)date formatType:(FormatType)type;

/**
 获取指定格式的日期
 
 @param dateStr 来源日期字符串
 @param fromFormatType 来源日期格式
 @param toFormatType 转换日期格式
 @return dateStr
 */
+ (NSString *)getDateStrWithDateStr:(NSString *)dateStr fromFormatType:(FormatType)fromFormatType toFormatType:(FormatType)toFormatType;

/**
 将时间戳转换为日期Str
 
 @param dateStample 时间戳
 @param type 日期类型
 @return date
 */
+ (NSString *)getDateStrWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type;

//TODO:获取date
/**
 将字符串转化为指定格式的日期
 @param dateStr 日期字符串
 @param type 日期类型
 @return date
 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr formatType:(FormatType)type;

/**
 获取指定格式的日期date
 @param date 转换的date
 @param type 类型
 @return date
 */
+ (NSDate *)getDateWithDate:(NSDate *)date formatType:(FormatType)type;

/**
 将时间戳转换为日期
 
 @param dateStample 时间戳
 @param type 日期类型
 @return date
 */
+ (NSDate *)getDateWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type;

//TODO:时间戳&比较大小
/**
 获取时间戳
 
 @param date 日期
 @return dateStample
 */
+ (NSTimeInterval)getDateStampleWithDate:(NSDate *)date;

/**
 比较时间大小

 @param dayStr 第一个时间Str
 @param anotherDayStr 第二个时间Str
 @param type 比较日期类型
 @return NSOrderedAscending=小于，NSOrderedSame=等于，NSOrderedDescending=大于
 */
+ (NSComparisonResult)compareOneDayStr:(NSString *)dayStr withAnotherDayStr:(NSString *)anotherDayStr formatType:(FormatType)type;


/**
 比较时间大小

 @param day 第一个时间
 @param anotherDay 第二个时间
 @return NSOrderedAscending=小于，NSOrderedSame=等于，NSOrderedDescending=大于
 */
+ (NSComparisonResult)compareOneDay:(NSDate *)day withAnotherDay:(NSDate *)anotherDay;


//TODO:日历处理
/** 获取日历基类 */
+ (NSCalendar *)getCalendar;
/** 获取年月日时分秒日历 */
+ (NSDateComponents *)getCalendarDateWithDate:(NSDate *)date;
+ (NSDateComponents *)getCalendarDateWithDateStr:(NSString *)dateStr formatType:(FormatType)type;
/** 获取日期 */
+ (NSDate *)getDateWithComponents:(NSDateComponents *)components;
/** 获取某月有几天 */
+ (NSInteger)getTotaldaysInMonthWithDate:(NSDate *)date;
/** 获取某月共有几周 */
+ (NSInteger)getTotalWeeksInMonthWithDate:(NSDate *)date;
/** 今天 */
+ (BOOL)isToday:(NSDate *)date;
/** 明天 */
+ (BOOL)isTomorrow:(NSDate *)date;
/** 后天 */
+ (BOOL)isAfterTomorrow:(NSDate *)date;
@end
