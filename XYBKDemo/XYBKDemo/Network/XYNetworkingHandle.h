//
//  XYNetworkingHandle.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYNetworkingHandle : NSObject
/** 添加公共参数 */
+ (NSDictionary *)addPublicParameters:(NSDictionary *)parameters;
/** 添加请求头 */
+ (NSMutableURLRequest *)addRequestHeader:(NSMutableURLRequest *)request;

/** id转jsonStr */
+ (NSString *)objectToJsonString:(id)object;
/** jsonStr转dic */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/** jsonData转dic */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData;

/** VC操作 */
+ (CustomTabBarViewController *)getCurrentCustomTab;
+ (CustomNavigationController *)getCurrentCustomNav;
+ (UIViewController *)getCurrentVC;

@end
