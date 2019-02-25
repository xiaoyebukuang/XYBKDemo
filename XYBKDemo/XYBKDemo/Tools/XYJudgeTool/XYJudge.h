//
//  XYJudge.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYJudge : NSObject

/** 验证相关 */
/** 验证手机号码及固定电话 */
+ (BOOL)validatePhoneNumber:(NSString *)mobileNum;
/** 字母、数字、中文正则判断（不包括空格） */
+ (BOOL)validateChineseNumber:(NSString *)temp;



/** 网络 */
+ (BOOL)checkNetworking;


/** 定位 */
+ (void)checkLocationAuthorizationStatus:(void(^)(BOOL handler))handler;

/** 相机、相册相关 */
/** 相机权限 */
+ (void)checkCameraAuthorizationStatus:(void(^)(BOOL handler))handler;
/** 相册权限 */
+ (void)checkPhotoLibraryAuthorizationStatus:(void(^)(BOOL handler))handler;

@end
