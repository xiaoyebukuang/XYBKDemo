//
//  XYNetworkingHandle.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYNetworkingHandle.h"
#import "NSString+MD5.h"
#import "DesEncryption.h"
#import "AppDelegate.h"
static NSString * const APP_MD5_KEY = @"0a5737ca40ce36f55004a93bda149f37";

@implementation XYNetworkingHandle
/** 添加公共参数 */
+ (NSDictionary *)addPublicParameters:(NSDictionary *)parameters {
    NSMutableDictionary *par;
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        par = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        par = [NSMutableDictionary dictionary];
    }
    NSString *idfa = [UIDevice getIDFA];
    NSString *machineCode = [UIDevice getDeviceOnlyUUID];
    NSString *deviceModel = [UIDevice getCurrentDeviceModel];
    NSString *systemVersion = [UIDevice getCurrentDeviceSystemVersion];
//    [par setValue:idfa forKey:@"idfa"];
//    [par setValue:[NSString stringWithFormat:@"%ld",(long)[NSDate getDateStampleWithDate:[NSDate date]]] forKey:@"timestamp"];
//    [par setValue:machineCode forKey:@"deviceNo"];
//    [par setValue:[UserModel sharedInstance].sessionToken forKey:@"sessionToken"];
//    [par setValue:SourceApp forKey:@"sourceApp"];
//    [par setValue:[UIDevice getAppVersion] forKey:@"appVersion"];
//    [par setValue:[UserModel sharedInstance].userCode forKey:@"userCode"];
//    [par setValue:deviceModel forKey:@"phoneModel"];
//    [par setValue:systemVersion forKey:@"sysVersion"];
//    NSString *phoneNo = [NSString safe_string:parameters[@"phoneNo"]];
//    if (phoneNo.length == 0) {
//        [par setValue:[UserModel sharedInstance].phoneNo forKey:@"phoneNo"];
//    }
    return par;
}/** 添加请求头 */
+ (NSMutableURLRequest *)addRequestHeader:(NSMutableURLRequest *)request {
    [request setValue:[UIDevice getAppVersion] forHTTPHeaderField:@"C_Version"];
    return request;
}
/** 加密 */
+ (NSDictionary *)encryptionWithParameters:(NSDictionary *)parameters {
    if (![parameters isKindOfClass:[NSDictionary class]]) {
        parameters = [NSMutableDictionary dictionary];
    } else {
        parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [newParameters setValue:[UserModel sharedInstance].accessToken forKey:@"accessToken"];
    
    NSMutableArray *paramterArr = [NSMutableArray array];
    NSArray *keys = [newParameters allKeys];
    for (int i = 0; i < keys.count; i ++) {
        NSString *key = keys[i];
        NSString *value = [NSString safe_string:newParameters[key]];
        if (value.length > 0) {
            NSString *temp = [NSString stringWithFormat:@"%@=%@",key,value];
            [paramterArr addObject:[temp uppercaseString]];
        }
    }
    NSArray *result = [paramterArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSString *signature = [result componentsJoinedByString:@"&"];
    signature = [signature uppercaseString];
    signature = [signature md5];
    [parameters setValue:signature forKey:@"signature"];
    //改成json
    NSString *jsonStr = [self objectToJsonString:parameters];
    NSString *desStr = [DesEncryption encryptUseDES:jsonStr];
    return @{@"body":desStr};
}
+ (NSDictionary *)getImageParameters:(NSDictionary *)parameters {
    if (![parameters isKindOfClass:[NSDictionary class]]) {
        parameters = [NSMutableDictionary dictionary];
    } else {
        parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }
    [parameters setValue:[NSString stringWithFormat:@"%ld",(long)[NSDate getDateStampleWithDate:[NSDate date]]] forKey:@"signature"];
    return parameters;
}
/** 解密 */
+ (NSDictionary *)decryptionWithData:(NSData *)data {
    //截取双引号
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //DEC解密
    NSString *jsonstr = [DesEncryption decryptUseDES:dataStr];
    //json转dic
    NSDictionary *dic = [self dictionaryWithJsonString:jsonstr];
    return dic;
}
/** id转jsonStr */
+ (NSString *)objectToJsonString:(id)object {
    if (object == nil) {
        return @"";
    }
    NSString *jsonString = [[NSString alloc]init];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    if (jsonString.length > 0) {
        return jsonString;
    }
    return @"";
}
/** jsonStr转dic */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (![jsonString isKindOfClass:[NSString class]]) {
        return @{};
    }
    if (jsonString == nil) {
        return @{};
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    NSDictionary *tempDic = [NSMutableDictionary correctDecimalLoss:[NSMutableDictionary dictionaryWithDictionary:dic]];
    if ([tempDic isKindOfClass:[NSDictionary class]]) {
        return tempDic;
    }
    return @{};
}
/** jsonData转dic */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData {
    NSString *encodeString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //去除加密串中的""双引号
    NSMutableString *mutStr = [NSMutableString stringWithFormat:@"%@",encodeString];
    if ([mutStr hasPrefix:@"\""]) {
        [mutStr deleteCharactersInRange:NSMakeRange(0,1)];
    }
    if ([mutStr hasSuffix:@"\""]) {
        [mutStr deleteCharactersInRange:NSMakeRange(mutStr.length - 1,1)];
    }
    //去除空格
    NSRange range = {0,mutStr.length};
    //去除换行符
    [mutStr replaceOccurrencesOfString:@"\n"
                            withString:@""
                               options:NSLiteralSearch range:range];
//    NSRange range2 = {0, mutStr.length};
//    //去除反斜杠
//    NSString * str = @"\\";
//    [mutStr replaceOccurrencesOfString:str
//                            withString:@""
//                               options:NSLiteralSearch range:range2];
    
    NSData *data = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}
/** jsonStr转array */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return @[];
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if ([arr isKindOfClass:[NSArray class]]) {
        return arr;
    }
    return @[];
}

+ (NSData *)imageData:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if (data.length > 1024*1024) {
        data = UIImageJPEGRepresentation(image, 0.5);
    } else if (data.length > 512*1024) {
        data = UIImageJPEGRepresentation(image, 0.5);
    } else if (data.length > 200*1024) {
        data = UIImageJPEGRepresentation(image, 0.7);
    }
    return data;
}


@end
