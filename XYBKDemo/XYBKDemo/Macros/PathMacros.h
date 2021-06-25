//
//  PathMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef PathMacros_h
#define PathMacros_h

/** 文件目录 */
#define PATH_HOME                   NSHomeDirectory()
#define PATH_DOCUMENT               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_CACHE                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_LIBRARY                [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_TEMP                   NSTemporaryDirectory()

//TODO:弱引用
#define WeakSelf                    __weak typeof(self) weakSelf = self;
#define WeakObj(o)                  __weak typeof(o) o##Weak = o;

/** 微信 */
#define kWXAppID                   @"wxcb148a86f93d5244"
/** QQ */
#define kQQAppID                   @"1101264411"8"
#define kWXAppSecret               @"6739edd93fc387bc2eaae7faa4505af0"
/** 百度 */
#define kBMKMapAppID               @"hIRTa1THzdxf4mKrkEKwxcw8FUEOOGAW"
/** 推送 */
#define JPUSHSAppId                @"9b2ae38fc2af849954bcd9f7"
/** Apple Pay 支付 */
#define AppleMerchantID            @"merchant.com.kata.cwz51"
/** 来源 */
#define SourceApp                  @"2"

#endif /* PathMacros_h */
