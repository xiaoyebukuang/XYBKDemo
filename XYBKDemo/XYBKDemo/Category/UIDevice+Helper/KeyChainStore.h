//
//  KeyChainStore.h
//  cwz51
//
//  Created by 陈晓 on 2019/4/28.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  KEY_USERNAME_PASSWORD @"com.kata.cwz51.changxiche"

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end

NS_ASSUME_NONNULL_END
