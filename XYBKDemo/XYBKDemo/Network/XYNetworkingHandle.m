//
//  XYNetworkingHandle.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYNetworkingHandle.h"
#import "AppDelegate.h"

@implementation XYNetworkingHandle
/** 添加公共参数 */
+ (NSDictionary *)addPublicParameters:(NSDictionary *)parameters {
    return parameters;
}/** 添加请求头 */
+ (NSMutableURLRequest *)addRequestHeader:(NSMutableURLRequest *)request {
    [request setValue:@"" forHTTPHeaderField:@"C_Version"];
    return request;
}
/** id转jsonStr */
+ (NSString *)objectToJsonString:(id)object {
    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
/** jsonStr转dic */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if(err) {
        return nil;
    }
    return [NSMutableDictionary correctDecimalLoss:tempDic];
}
/** jsonData转dic */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData {
    NSString *encodeString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self dictionaryWithJsonString:encodeString];
}


//TODO:视图控制器操作
/** 获取当前的tabBar */
+ (CustomTabBarViewController *)getCurrentCustomTab {
    AppDelegate *appDelegate = kApplicationDelegate;
    UIViewController *tabBarVC = appDelegate.window.rootViewController;
    if ([tabBarVC isKindOfClass:[CustomTabBarViewController class]]) {
        return (CustomTabBarViewController *)tabBarVC;
    } else {
        return nil;
    }
}
/** 获取当前的Nac */
+ (CustomNavigationController *)getCurrentCustomNav {
    CustomTabBarViewController *tabBarVC = [self getCurrentCustomTab];
    if (tabBarVC) {
        UIViewController *currentVC = ((CustomTabBarViewController *)tabBarVC).selectedViewController;
        return (CustomNavigationController *)currentVC;
    } else {
        return nil;
    }
}
/** 获取当前的VC */
+ (UIViewController *)getCurrentVC {
    CustomNavigationController *nav = [self getCurrentCustomNav];
    if (nav) {
        return nav.childViewControllers.lastObject;
    } else {
        return nil;
    }
}
@end
