//
//  NSString+URL.m
//  cwz51
//
//  Created by 陈晓 on 2018/12/13.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSString+URL.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
@implementation NSString (URL)
/**
 *  URLEncode
 */
- (NSString *)URLEncodedString {
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];;
}
/**
 *  URLDecode
 */
-(NSString *)URLDecodedString {
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)self,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
/** 获取参数 */
+ (NSDictionary *)getParamsWithUrlString:(NSString*)urlString {
    if(urlString.length == 0) {
        return @{};
    }
    NSString *tempStr = urlString;
    if ([urlString containsString:@"?"]) {
        NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
        if (allElements.count > 2) {
            return @{};
        } else {
            tempStr = allElements[1];
        }
    } else if ([urlString containsString:@"://"]) {
        NSRange range = [urlString rangeOfString:@"://"];
        tempStr = [urlString substringFromIndex:range.location + range.length];
    }
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSArray *dataArr = [tempStr componentsSeparatedByString:@"&"];
    for (NSString *tempStr in dataArr) {
        NSArray *tempArr = [tempStr componentsSeparatedByString:@"="];
        if (tempArr.count == 2) {
            NSString *key = [NSString safe_string:tempArr.firstObject];
            NSString *value = [NSString safe_string:tempArr.lastObject];
            if (key.length != 0) {
                [dataDic setValue:value forKey:key];
            }
        }
    }
    return dataDic;
}
/** 获取链接 */
+ (NSString *)getUrlWithUrl:(NSString *)urlString params:(NSDictionary *)params {
    urlString = [NSString safe_string:urlString];
    NSString *paramsStr = @"";
    NSArray *keyArray = params.allKeys;
    for (NSString *key in keyArray) {
        NSString *value = params[key];
        if (paramsStr.length == 0) {
            paramsStr = [paramsStr stringByAppendingFormat:@"%@=%@",[NSString safe_string:key],[NSString safe_string:value]];
        } else {
            paramsStr = [paramsStr stringByAppendingFormat:@"&%@=%@",[NSString safe_string:key],[NSString safe_string:value]];
        }
    }
    if (paramsStr.length == 0) {
        return urlString;
    }
    if ([urlString containsString:@"?"]) {
        NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
        if (allElements.count < 2) {
            urlString = [urlString stringByAppendingString:@"?"];
        } else {
            NSString *tempStr = allElements[1];
            if (tempStr.length == 0) {
                urlString = [urlString stringByAppendingString:@"?"];
            } else {
                urlString = [urlString stringByAppendingString:@"&"];
            }
        }
    } else {
       urlString = [urlString stringByAppendingString:@"?"];
    }
    return [NSString stringWithFormat:@"%@%@",urlString,paramsStr];
}
/** 普通字符串转换为十六进制的 */
+ (NSString *)hexStringFromString:(NSString *)string {
    NSString *tempStr = [NSString safe_string:string];
    NSData *myD = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i = 0; i < [myD length]; i++ ) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}
/** 十六进制转换为普通字符串的 */
+ (NSString *)stringFromHexString:(NSString *)hexString {
   char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
   bzero(myBuffer, [hexString length] / 2 + 1);
   for (int i = 0; i < [hexString length] - 1; i += 2) {
       unsigned int anInt;
       NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
       NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
       [scanner scanHexInt:&anInt];
       myBuffer[i / 2] = (char)anInt;
   }
   NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
   return [NSString safe_string:unicodeString];
}
/**
 *  对NSString进行处理
 *  @param key  要加密key
 *  @param string 加密的data
 *  @return 加密后的字符串
*/
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)string {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [string cStringUsingEncoding:NSUTF8StringEncoding];
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for ( int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", cHMAC[i]];
    }
    hash = output;
    return hash;
}
/** 将中文编码 */
+ (NSString *)getChineseCodingUrlWithUrlString:(NSString *)urlString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)urlString,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end
