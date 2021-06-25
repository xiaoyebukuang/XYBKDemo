//
//  DesEncryption.h
//  EncryptionDemo
//
//  Created by SDMac on 15/7/21.
//  Copyright (c) 2015年 SDMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesEncryption : NSObject
/**
 *  Des加密
 *
 *  @param plainText 需要加密的文本
 *
 *  @return 返回加密密文
 */
+ (NSString *)encryptUseDES:(NSString *)plainText;

/**
 *  Des解密
 *
 *  @param cipherText 需要加密的文本
 *
 *  @return 返回解密文本
 */
+ (NSString*)decryptUseDES:(NSString*)cipherText;


@end
