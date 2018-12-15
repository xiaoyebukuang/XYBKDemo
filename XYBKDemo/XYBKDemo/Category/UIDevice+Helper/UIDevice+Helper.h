//
//  UIDevice+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Helper)
/** 设备唯一id ->UUID */
+ (NSString *)getDeviceOnlyUUID;
/** 获取app版本号 */
+ (NSString *)getAppVersion;
/** 获取app名称 */
+ (NSString *)getAppName;
/** 获取buildId */
+ (NSString *)getAppBuildID;
/** 获取设备IP地址 */
+ (NSString *)getDeviceIPAddress:(BOOL)preferIPv4;
/** 拨打电话 */
+ (void)callTel:(NSString *)tel;
@end
