//
//  DesEncryption.m
//  EncryptionDemo
//
//  Created by SDMac on 15/7/21.
//  Copyright (c) 2015年 SDMac. All rights reserved.
//

#import "DesEncryption.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "iconv.h"


@implementation DesEncryption

/** Des加密 */
+ (NSString *)encryptUseDES:(NSString *)plainText {
    NSData* encryptData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *ciphertext = nil;
    const char *textBytes = (const void *)[encryptData bytes];
    NSUInteger dataLength = [encryptData length];
    size_t bufferPtrSize = (dataLength + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = NULL;
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    size_t numBytesEncrypted = 0;
    const void *iv = (const void *)[APP_SECRET_GIV UTF8String];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [APP_SECRET_KEY UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes,
                                          dataLength,
                                          (void *)bufferPtr, bufferPtrSize, // 可以修改,设置可以解密的最大的密文长度
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:(void *)bufferPtr length:(NSUInteger)numBytesEncrypted];
        ciphertext =[GTMBase64 stringByEncodingData:data];
    }
    return ciphertext;
}
/** Des解密 */
+ (NSString*)decryptUseDES:(NSString*)cipherText {
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    size_t bufferPtrSize = (cipherData.length + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = NULL;
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    size_t numBytesDecrypted = 0;
    const void *iv = (const void *)[APP_SECRET_GIV UTF8String];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [APP_SECRET_KEY UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          (void *)bufferPtr,
                                          bufferPtrSize, // 可以修改,设置可以解密的最大的密文长度
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:(void *)bufferPtr length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

+ (NSString *)parseByte2HexString:(Byte *)bytes {
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes) {
        while (bytes[i] != '\0') {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            i++;
        }
    }
    return hexStr;
}
+ (NSString *) parseByteArray2HexString:(Byte[]) bytes {
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes) {
        while (bytes[i] != '\0') {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            i++;
        }
    }
    return hexStr;
}

@end
