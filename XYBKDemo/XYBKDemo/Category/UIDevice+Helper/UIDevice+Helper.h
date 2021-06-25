//
//  UIDevice+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Helper)
/** 获取手机广告标识符 */
+ (NSString *)getIDFA;
/** 设备手机唯一id ->UUID */
+ (NSString *)getDeviceOnlyUUID;
/** 获取手机设备IP地址 */
+ (NSString *)getDeviceIPAddress:(BOOL)preferIPv4;
/** 获取手机设备型号 */
+ (NSString *)getCurrentDeviceModel;
/** 获取手机设备系统名称 */
+ (NSString *)getCurrentDeviceSystemVersion;
/** 获取app版本号 */
+ (NSString *)getAppVersion;
/** 获取app名称 */
+ (NSString *)getAppName;
/** 获取buildId */
+ (NSString *)getAppBuildID;
/** 拨打电话 */
+ (void)callTel:(NSString *)tel;
/** 拨打电话 */
+ (void)callCompleteTel:(NSString *)tel;
/** 打开设置 */
+ (void)openSetting;
/** 打开链接 */
+ (void)openURLStr:(NSString *)urlStr;

@end
