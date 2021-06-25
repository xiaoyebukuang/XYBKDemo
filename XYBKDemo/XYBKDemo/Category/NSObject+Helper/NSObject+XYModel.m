//
//  NSObject+XYModel.m
//  changxiche
//
//  Created by 陈晓 on 2021/6/21.
//

#import "NSObject+XYModel.h"
#import <YYModel/YYModel.h>

@implementation NSObject (XYModel)
+ (instancetype)xy_modelWithDictionary:(NSDictionary *)dataDic {
    return [self yy_modelWithDictionary:dataDic];
}
@end
