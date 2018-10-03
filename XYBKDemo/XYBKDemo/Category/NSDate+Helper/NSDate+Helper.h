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
 将字符串转化为指定格式的日期
 @param dateStr 日期字符串
 @param type 日期类型
 @return date
 */
+ (NSDate *)getDateWithDateStr:(NSString *)dateStr formatType:(FormatType)type;

/**
 获取时间戳
 
 @param date 日期
 @return dateStample
 */
+ (NSTimeInterval)getDateStampleWithDate:(NSDate *)date;


/**
 将时间戳转换为日期

 @param dateStample 时间戳
 @param type 日期类型
 @return date
 */
+ (NSDate *)getDateWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type;

/**
 将时间戳转换为日期Str
 
 @param dateStample 时间戳
 @param type 日期类型
 @return date
 */
+ (NSString *)getDateStrWithDateStample:(NSTimeInterval)dateStample formatType:(FormatType)type;

@end
