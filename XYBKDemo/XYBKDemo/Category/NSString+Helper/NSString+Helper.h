//
//  NSString+Helper.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/** 返回安全的字符串 */
+ (NSString *)safe_string:(id)obj;
/** 保留两个小数 */
+ (NSString *)safe_twoDecimal:(id)obj;
/** 保留一个小数 */
+ (NSString *)safe_oneDecimal:(id)obj;
/** 返回float型 */
+ (float)safe_float:(id)obj;
/** 返回intefer型 */
+ (NSInteger)safe_integer:(id)obj;
@end
