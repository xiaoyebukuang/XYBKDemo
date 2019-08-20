//
//  UIImage+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2018/12/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

/** 压缩图片到指定data */
- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;
/** 压缩图片指定image */
- (UIImage *)getImageWithMaxLength:(NSUInteger)maxLength;


/** 裁剪图片到指定比例 width/height */
- (UIImage *)cutOutImageWithScale:(CGFloat)imageScale;

@end
