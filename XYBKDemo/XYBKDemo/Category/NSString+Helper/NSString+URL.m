//
//  NSString+URL.m
//  cwz51
//
//  Created by 陈晓 on 2018/12/13.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSString+URL.h"

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
@end
