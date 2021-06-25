//
//  XYNetworkingHandle.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XYNetworkingHandle : NSObject
/** 添加公共参数 */
+ (NSDictionary *)addPublicParameters:(NSDictionary *)parameters;
/** 添加请求头 */
+ (NSMutableURLRequest *)addRequestHeader:(NSMutableURLRequest *)request;
/** 加密 */
+ (NSDictionary *)encryptionWithParameters:(NSDictionary *)parameters;
+ (NSDictionary *)getImageParameters:(NSDictionary *)parameters;
/** 解密 */
+ (NSDictionary *)decryptionWithData:(NSData *)data;


/** id转jsonStr */
+ (NSString *)objectToJsonString:(id)object;
/** jsonStr转dic */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/** jsonData转dic */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData;
/** jsonStr转array */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;

/** 获取图片data */
+ (NSData *)imageData:(UIImage *)image;



@end
