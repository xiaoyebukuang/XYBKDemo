//
//  XYNetworkingHandle.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYNetworkingHandle.h"

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
    if(err) {
        return nil;
    }
    return dic;
}
/** jsonData转dic */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData {
    NSString *encodeString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self dictionaryWithJsonString:encodeString];
}
@end
