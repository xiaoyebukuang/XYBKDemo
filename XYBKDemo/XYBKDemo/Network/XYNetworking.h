//
//  XYNetworking.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/24.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NO_NETWORK_ALERT                @"服务器开小差..."
#define NO_REALLY_NETWORK_ALERT         @"请检查您的网络..."

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
                   keyArr:(NSArray *)keyArr
            multipartForm:(BOOL)multipartForm
                 imageArr:(NSArray *)imageArray
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure;


/** 使用AFN框架来检测网络状态的改变 */
- (void)reachabilityStatusChange;
/** 检查网络状态 */
- (BOOL)checkNetworking;

/** 删除所有请求 */
+ (void)cancelAllTask;
/** 清除浏览器缓存 */
+ (void)cleanCacheAndCookie;

@end
