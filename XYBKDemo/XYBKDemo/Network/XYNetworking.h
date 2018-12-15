//
//  XYNetworking.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ErrorType) {
    ErrorTypeNoNetwork,         //没有网络
    ErrorTypeReqestNone,        //超时
    ErrorTypeRequestFailed      //请求失败
};
typedef void(^XYNetworkSueecss)(id obj, NSString *resultDesc);
typedef void(^XYNetworkFailure)(ErrorType errorType, NSString *mes, NSString *resultCode);
typedef void(^XYNetworkProgress)(CGFloat progress);
@interface XYNetworking : NSObject

+ (instancetype)shareInstance;

/** post请求(url) */
+ (void)postWithUrlString:(NSString *)urlString
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;

/** post请求(url+清除) */
+ (void)postWithUrlString:(NSString *)urlString
                   cancel:(BOOL)cancle
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;

/** post请求(url+参数) */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;
/** post请求(url+参数+清除) */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;

/** post请求(url+参数+下载进度) */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;
/** post请求（url+参数+清除+下载进度） */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;

/** post请求（url+参数+清除+下载进度+图片上传） */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
                 imageArr:(NSArray *)imageArray
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;

/** 清除所有请求 */
+ (void)cancelAllTask;
/** 检查网络状态 */
+ (BOOL)checkNetworking;

@end
