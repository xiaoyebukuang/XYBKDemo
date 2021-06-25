//
//  UIJudgeTool.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIJudgeTool : NSObject

//TODO:验证相关
/** 验证手机号码及固定电话 */
+ (BOOL)validatePhoneNumber:(NSString *)mobileNum;
/** 隐藏手机号中间四位 */
+ (NSString *)hidePhoneNumber:(NSString *)mobileNum;
/** 字母、数字、中文正则判断（不包括空格） */
+ (BOOL)validateChineseNumber:(NSString *)temp;


//TODO:权限

//TODO:定位
/** 定位 */
+ (void)checkLocationAuthorizationStatus:(void(^)(BOOL handler))handler;

//TODO:相机、相册
/** 相机权限 */
+ (void)checkCameraAuthorizationStatus:(void(^)(BOOL handler))handler;
/** 相册权限 */
+ (void)checkPhotoLibraryAuthorizationStatus:(void(^)(BOOL handler))handler;

//TODO:推送
/** 是否开启推送 */
+ (BOOL)checkUserNotificationEnable;
@end
