//
//  XYNetworking.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/24.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYNetworking.h"
#import "AFNetworking.h"
#import "XYNetworkingHandle.h"
#import "Reachability.h"
#import <WebKit/WebKit.h>
static XYNetworking *_networking = nil;
static NSTimeInterval const timeInterval = 30.0;

@interface XYNetworking()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *tasks;
//网络状态
@property (nonatomic, assign) AFNetworkReachabilityStatus reachabilityStatus;

@end

@implementation XYNetworking
+ (instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _networking = [[self alloc] init] ;
        _networking.manager = [[AFHTTPSessionManager alloc]init];
        _networking.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_networking.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _networking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _networking.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"application/xml", nil];
        _networking.manager.requestSerializer.timeoutInterval = timeInterval;
        _networking.tasks = [[NSMutableArray alloc]init];
    }) ;
    return _networking ;
}
/** post请求(url) */
+ (void)postWithUrlString:(NSString *)urlString
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    [self postWithUrlString:urlString parameters:nil success:success failure:failure];
}
/** post请求(url+清除) */
+ (void)postWithUrlString:(NSString *)urlString
                   cancel:(BOOL)cancle
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    [self  postWithUrlString:urlString parameters:nil cancel:cancle success:success failure:failure];
}

/** post请求(url+参数) */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    [self postWithUrlString:urlString parameters:parameters downloadProgress:nil success:success failure:failure];
}
/** post请求(url+参数+清除) */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    [self postWithUrlString:urlString parameters:parameters cancel:cancle downloadProgress:nil success:success failure:failure];
}

/** post请求(url+参数+下载进度) */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    [self postWithUrlString:urlString parameters:parameters cancel:YES downloadProgress:downloadPro success:success failure:failure];
}
/** post请求（url+参数+清除+下载进度） */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    [self postWithUrlString:urlString parameters:parameters cancel:cancle keyArr:nil multipartForm:NO imageArr:nil downloadProgress:downloadPro success:success failure:failure];
}
/** post请求（url+参数+清除+下载进度+图片上传） */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
                   keyArr:(NSArray *)keyArr
            multipartForm:(BOOL)multipartForm
                 imageArr:(NSArray *)imageArray
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    if (![[self shareInstance]checkNetworking]) {
        failure(ErrorTypeNoNetwork, NO_REALLY_NETWORK_ALERT, @"9999");
        return;
    }
    /** 添加公共参数 */
    parameters = [XYNetworkingHandle addPublicParameters:parameters];
    /** 设置请求 */
    XYNetworking *network = [self shareInstance];
    NSError *error;
    NSMutableURLRequest *request;
    if (!multipartForm) {
        //加密jsonDiC
        NSDictionary *jsonDic = [XYNetworkingHandle encryptionWithParameters:parameters];
        request = [network.manager.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:jsonDic error:&error];
    } else {
        NSDictionary *jsonDic = [XYNetworkingHandle getImageParameters:parameters];;
        request = [network.manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:jsonDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0; i < imageArray.count; i ++) {
                UIImage *image=  imageArray[i];
                NSData *data = [image compressWithMaxLength:1024*2*1024];
                NSString *dataStr = [NSDate getDateStrWithDate:[NSDate date] formatType:FormatDefault];
                if (keyArr.count > i) {
                    dataStr = keyArr[i];
                }
                [formData appendPartWithFileData:data name:@"files" fileName:[NSString stringWithFormat:@"%@.png",dataStr] mimeType:@"multipart/form-data"];
            }
        } error:&error];
    }
    //添加请求头
    request = [XYNetworkingHandle addRequestHeader:request];
    
    NSURLSessionDataTask *dataTask = [network.manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        //上传
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        //下载
        if (downloadProgress.totalUnitCount > 0) {
            if (downloadPro) {
                downloadPro(downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
            }
        } else {
            if (downloadPro) {
                downloadPro(1.0);
            }
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        //解密环节
        NSDictionary *subDic = [XYNetworkingHandle decryptionWithData:responseObject];
        NSLog(@"-----------------------------------");
        NSLog(@"subDic = %@",subDic);
        NSLog(@"parameters = %@",parameters);
        NSLog(@"urlString = %@",urlString);
        NSLog(@"-----------------------------------");
        if ([subDic isKindOfClass:[NSDictionary class]]) {
            NSString *resultCode = [NSString safe_string:subDic[@"resultCode"]];
            if ([resultCode isEqualToString:@"0000"]) {
                NSString *resultDesc = [NSString safe_string:subDic[@"resultDesc"]];
                success([subDic valueForKey:@"data"],resultDesc);
            } else if ([resultCode isEqualToString:@"2004"]||[resultCode isEqualToString:@"2002"]||[resultCode isEqualToString:@"2001"]) {
//                if ([UserModel sharedInstance].loginState) {
//                    [[UserModel sharedInstance] signOut];
//                    [MBProgressHUD showError:@"登录失效，请重新登录"];
//                    [JumpLinkModel backToMineVC];
//                }
                failure(ErrorTypeRequestFailed, @"登录失效，请重新登录", subDic[@"resultCode"]);
            } else if (resultCode.length == 0 || [resultCode isEqualToString:@"9999"]) {
                NSString *resultDesc = NO_NETWORK_ALERT;
                failure(ErrorTypeRequestFailed, resultDesc, @"9999");
            } else {
                NSString *resultDesc = [NSString safe_string:subDic[@"resultDesc"]];
                failure(ErrorTypeRequestFailed, resultDesc, [NSString safe_string:subDic[@"resultCode"]]);
            }
        } else {
            failure(ErrorTypeReqestNone, NO_NETWORK_ALERT, @"9999");
        }
    }];
    [dataTask resume];
    if (cancle) {
        [network.tasks addObject:dataTask];
    }
}
/** 使用AFN框架来检测网络状态的改变 */
- (void)reachabilityStatusChange {
    //1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //2.监听网络状态的改变
    /*
     AFNetworkReachabilityStatusUnknown     = 未知
     AFNetworkReachabilityStatusNotReachable   = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //未知
                self.reachabilityStatus = AFNetworkReachabilityStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //无网
                self.reachabilityStatus = AFNetworkReachabilityStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //蜂窝
                if (self.reachabilityStatus == AFNetworkReachabilityStatusUnknown) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETWORK_AUTO_SUCCESS object:self];
                }
                self.reachabilityStatus = AFNetworkReachabilityStatusReachableViaWWAN;
            }
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                if (self.reachabilityStatus == AFNetworkReachabilityStatusUnknown) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETWORK_AUTO_SUCCESS object:self];
                }
                self.reachabilityStatus = AFNetworkReachabilityStatusReachableViaWiFi;
            }
                break;
            default:
                break;
        }
    }];
    //3.开始监听
    [manager startMonitoring];
}
/** 检查网络状态 */
- (BOOL)checkNetworking {
    Reachability * reachbility = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status=[reachbility currentReachabilityStatus];
    if (status == ReachableViaWiFi || status == ReachableViaWWAN) {
        return YES;
    } else {
        return NO;
    }
}
/** 清除所有请求 */
+ (void)cancelAllTask {
    XYNetworking *network = [self shareInstance];
    for (NSURLSessionDataTask *task in network.tasks) {
        [task cancel];
    }
}
/** 清除浏览器缓存 */
+ (void)cleanCacheAndCookie {
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom =  [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore]removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}


@end
