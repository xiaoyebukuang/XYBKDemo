//
//  UIDevice+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Helper)
/** 获取广告标识符 */
+ (NSString *)getIDFA;
/** 设备唯一id ->UUID */
+ (NSString *)getDeviceOnlyUUID;
/** 获取设备IP地址 */
+ (NSString *)getDeviceIPAddress;
/** 获取app版本号 */
+ (NSString *)getAppVersion;
/** 获取app名称 */
+ (NSString *)getAppName;
/** 获取buildId */
+ (NSString *)getAppBuildID;
/** 拨打电话 */
+ (void)callTel:(NSString *)tel;
/** 打开链接 */
+ (void)openURLStr:(NSString *)urlStr;
/** 打开设置 */
+ (void)openSetting;

/** 缓存 */
+ (void)cleanCacheAndCookie;
+ (void)clearAnyeLocalCache;

@end
