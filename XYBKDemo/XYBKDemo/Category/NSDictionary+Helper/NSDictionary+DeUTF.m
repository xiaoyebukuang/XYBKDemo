//
//  NSDictionary+DeUTF.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "NSDictionary+DeUTF.h"

@implementation NSDictionary (DeUTF)
- (NSString *)descriptionWithLocale:(id)locale {
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value = self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key,value];
    }
    [str appendString:@"}"];
    return str;
}
@end
