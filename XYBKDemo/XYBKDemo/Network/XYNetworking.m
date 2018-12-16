//
//  XYNetworking.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYNetworking.h"
#import "AFNetworking.h"
#import "Reachability.h"
static XYNetworking *_networking = nil;
static NSTimeInterval const timeInterval = 30.0;

@interface XYNetworking()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *tasks;

@end

@implementation XYNetworking

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _networking = [[self alloc] init] ;
        _networking.manager = [[AFHTTPSessionManager alloc]init];
        _networking.manager.requestSerializer = [AFJSONRequestSerializer serializer];
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
    [self postWithUrlString:urlString parameters:parameters cancel:cancle imageArr:nil downloadProgress:downloadPro success:success failure:failure];
}
/** post请求（url+参数+清除+下载进度+图片上传） */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                   cancel:(BOOL)cancle
                 imageArr:(NSArray *)imageArray
         downloadProgress:(XYNetworkProgress)downloadPro
                  success:(XYNetworkSueecss)success
                  failure:(XYNetworkFailure)failure {
    if (![self checkNetworking]) {
        failure(ErrorTypeNoNetwork, @"请检查您的网络", @"9999");
        return;
    }
    /** 添加公共参数 */
    parameters = [XYNetworkingHandle addPublicParameters:parameters];
    /** 设置请求 */
    XYNetworking *network = [self shareInstance];
    NSError *error;
    NSMutableURLRequest *request;
    if (imageArray == nil) {
        request = [network.manager.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:parameters error:&error];
    } else {
        request = [network.manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0; i < imageArray.count; i ++) {
                UIImage *image = imageArray[i];
                NSData *data;
                NSString *dataStr = [NSDate getDateStrWithDate:[NSDate date] formatType:FormatDefault];
                [formData appendPartWithFileData:data name:@"files" fileName:[NSString stringWithFormat:@"%@.jpeg",dataStr] mimeType:@"multipart/form-data"];
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
        NSLog(@"-----------------------------------");
//        NSLog(@"subDic = %@",subDic);
        NSLog(@"parameters = %@",parameters);
        NSLog(@"urlString = %@",urlString);
        NSLog(@"-----------------------------------");
    }];
    [dataTask resume];
    if (cancle) {
        [network.tasks addObject:dataTask];
    }
}
/** 清除所有请求 */
+ (void)cancelAllTask {
    XYNetworking *network = [self shareInstance];
    for (NSURLSessionDataTask *task in network.tasks) {
        [task cancel];
    }
}
/** 检查网络状态 */
+ (BOOL)checkNetworking {
    Reachability * reachbility = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reachbility currentReachabilityStatus];
    if (status == ReachableViaWiFi || status == ReachableViaWWAN) {
        return YES;
    } else {
        return NO;
    }
    
}


@end
