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

@end
