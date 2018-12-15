//
//  UIImage+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2018/12/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

/** 压缩图片到指定大小 */
- (NSData *)compressWithMaxLength:(NSUInteger)maxLength;
/** 裁剪图片到指定比例 */
- (UIImage *)cutOutImageWithScale:(CGFloat)imageScale;

@end
