//
//  NSString+URL.h
//  cwz51
//
//  Created by 陈晓 on 2018/12/13.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
/**
 *  URLEncode加密
 */
- (NSString *)URLEncodedString;
/**
 *  URLDecode
 */
- (NSString *)URLDecodedString;
/**
 获取url中的参数并返回
 @param urlString 带参数的url
 @return @[NSString:无参数url, NSDictionary:参数字典]
 */
+ (NSDictionary *)getParamsWithUrlString:(NSString*)urlString;

+ (NSString *)getUrlWithUrl:(NSString *)urlString params:(NSDictionary *)params;


/** 普通字符串转换为十六进制的 */
+ (NSString *)hexStringFromString:(NSString *)string;
/** 十六进制转换为普通字符串的 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

/** HMAC  hash  Sha1加密 */
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)string;

/** 将中文编码 */
+ (NSString *)getChineseCodingUrlWithUrlString:(NSString *)urlString;

@end
