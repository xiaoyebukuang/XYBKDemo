//
//  UIJudgeTool.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIJudgeTool.h"
#import <Photos/Photos.h>
#import <CoreLocation/CLLocationManager.h>
@implementation UIJudgeTool

#pragma mark -- 判断
/** 验证手机号码及固定电话 */
+ (BOOL)validatePhoneNumber:(NSString *)mobileNum {
    if (mobileNum.length == 11) {
        return YES;
    }
    return NO;
}
/** 隐藏手机号中间四位 */
+ (NSString *)hidePhoneNumber:(NSString *)mobileNum {
    if ([self validatePhoneNumber:mobileNum]) {
        return [mobileNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    } else {
        return mobileNum;
    }
}
/** 字母、数字、中文正则判断（不包括空格） */
+ (BOOL)validateChineseNumber:(NSString *)temp {
    NSString *pattern = @"[➋➌➍➎➏➐➑➒0-9a-zA-Z\u4e00-\u9fa5]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:temp];
}

#pragma mark -- 定位
/**
     kCLAuthorizationStatusNotDetermined = 0,   //用户没有选择是否要使用定位服务（弹框没选择，或者根本没有弹框）
     kCLAuthorizationStatusRestricted,          //定位服务授权状态受限制
     kCLAuthorizationStatusDenied,              //用户在设置中关闭定位功能，或者用户明确的在弹框之后选择禁止定位
     kCLAuthorizationStatusAuthorizedAlways     //App始终允许使用定位功能NS_ENUM_AVAILABLE(10_12, 8_0),
     kCLAuthorizationStatusAuthorizedWhenInUse  //用户在使用期间允许使用定位功能NS_ENUM_AVAILABLE(NA, 8_0),
     kCLAuthorizationStatusAuthorized NS_ENUM_DEPRECATED(10_6, NA, 2_0, 8_0, "Use kCLAuthorizationStatusAuthorizedAlways") __TVOS_PROHIBITED __WATCHOS_PROHIBITED = kCLAuthorizationStatusAuthorizedAlways ////用户已经明确使用定位功能
 */
+ (void)checkLocationAuthorizationStatus:(void(^)(BOOL handler))handler {
    //确定用户的位置服务是否启用,位置服务在设置中是否被禁用
    BOOL enable = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    if (enable) {
        switch (status) {
            case kCLAuthorizationStatusRestricted:
            case kCLAuthorizationStatusDenied:
                handler(NO);
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            case kCLAuthorizationStatusNotDetermined:
                handler(YES);
                break;
            default:
                handler(YES);
                break;
        }
    } else {
        handler(NO);
    }
}
#pragma mark -- 相机相册相关
/** 判断设备是否有摄像头 */
+ (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
/** 前面的摄像头是否可用 */
+ (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
/** 是否可使用摄像头
 AVAuthorizationStatusNotDetermined = 0, // 系统还未知是否访问，第一次开启相机时
 AVAuthorizationStatusRestricted,        // 受限制的
 AVAuthorizationStatusDenied,            //不允许
 AVAuthorizationStatusAuthorized         // 允许状态
 */
+ (void)checkCameraAuthorizationStatus:(void(^)(BOOL handler))handler {
    if ([self isCameraAvailable] && [self isFrontCameraAvailable]) {
        AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
        switch (AVstatus) {
            case AVAuthorizationStatusNotDetermined:
            {
                [self requestCameraAuthorizationStatus:^(BOOL newHandler) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(newHandler);
                        if (!newHandler) {
                            [self showCameraOrPhotoLibrarySetting];
                        }
                    });
                }];
            }
                break;
            case AVAuthorizationStatusRestricted:
            {
                handler(NO);
                [self showCameraOrPhotoLibrarySetting];
            }
                break;
            case AVAuthorizationStatusDenied:
            {
                handler(NO);
                [self showCameraOrPhotoLibrarySetting];
            }
                break;
            case AVAuthorizationStatusAuthorized:
                handler(YES);
                break;
            default:
                break;
        }
    } else {
        {
            handler(NO);
            [self showCameraOrPhotoLibrarySetting];
        }
    }
}
+ (void)requestCameraAuthorizationStatus:(void(^)(BOOL handler))handler {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        handler(granted);
    }];
}
/** 判断设备是否有相册 */
+ (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
/** 是否可使用相册
 PHAuthorizationStatusNotDetermined = 0, // 系统还未知是否访问，第一次开启相机时
 PHAuthorizationStatusRestricted,        // 受限制的
 PHAuthorizationStatusDenied,            //不允许
 PHAuthorizationStatusAuthorized         // 允许状态
 */
+ (void)checkPhotoLibraryAuthorizationStatus:(void(^)(BOOL handler))handler {
    if ([self isPhotoLibraryAvailable]) {
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthorStatus) {
            case PHAuthorizationStatusNotDetermined:
            {
                [self requestPhotoLibraryAuthorizationStatus:^(BOOL newHandler) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(newHandler);
                        if (!newHandler) {
                            [self showCameraOrPhotoLibrarySetting];
                        }
                    });
                }];
            }
                break;
            case PHAuthorizationStatusRestricted:
            {
                handler(NO);
                [self showCameraOrPhotoLibrarySetting];
            }
                break;
            case PHAuthorizationStatusDenied:
            {
                handler(NO);
                [self showCameraOrPhotoLibrarySetting];
            }
                break;
            case PHAuthorizationStatusAuthorized:
                handler(YES);
                break;
            default:
                break;
        }
    } else {
        {
            handler(NO);
            [self showCameraOrPhotoLibrarySetting];
        }
    }
}
+ (void)showCameraOrPhotoLibrarySetting {
    NSString *message = [NSString stringWithFormat:@"请为%@开放相机权限:手机设置->隐私->相机->%@(打开)",[UIDevice getAppName],[UIDevice getAppName]];
    [UIAlertViewTool showTitle:@"无法启动相机" message:message titlesArr:@[@"取消",@"去设置"] alertBlock:^(NSString *mes, NSInteger index) {
        if (index == 1) {
            [UIDevice openSetting];
        }
    }];
}
+ (void)requestPhotoLibraryAuthorizationStatus:(void(^)(BOOL handler))handler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
                // --授权中
            case PHAuthorizationStatusNotDetermined:
                handler(NO);
                break;
                // --没权限
            case PHAuthorizationStatusRestricted:
                handler(NO);
                break;
                // --没权限
            case PHAuthorizationStatusDenied:
                handler(NO);
                break;
                // --已授权
            case PHAuthorizationStatusAuthorized:
                handler(YES);
                break;
            default:
                break;
        }
    }];
}
#pragma mark -- 推送
/** 是否开启推送 */
+ (BOOL)checkUserNotificationEnable {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    return setting.types == UIUserNotificationTypeNone ? NO : YES;
}

@end
