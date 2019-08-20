//
//  UIImage+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2018/12/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIImage+Helper.h"
@implementation UIImage (Helper)
/** 压缩图片到指定data */
- (NSData *)compressWithMaxLength:(NSUInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}
/** 压缩图片指定image */
- (UIImage *)getImageWithMaxLength:(NSUInteger)maxLength {
    NSData *imageData = [self compressWithMaxLength:maxLength];
    return [UIImage imageWithData:imageData];
}
/** 裁剪图片到指定比例 */
- (UIImage *)cutOutImageWithScale:(CGFloat)imageScale {
    CGFloat mianscale = [UIScreen mainScreen].scale;
    CGRect dianRect;
    CGFloat currentScale = self.size.width/self.size.height;
    if (currentScale >= imageScale) {
        //宽度比例大，以高度为基准
        CGFloat width = self.size.height*imageScale;
        CGFloat heigth = self.size.height;
        dianRect = CGRectMake((self.size.width - width)/2, (self.size.height - heigth)/2, width, heigth);
    } else {
        //宽度比例小，以宽度为基准
        CGFloat width = self.size.width;
        CGFloat heigth = self.size.width/imageScale;
        dianRect = CGRectMake((self.size.width - width)/2, (self.size.height - heigth)/2, width, heigth);
    }
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:mianscale orientation:UIImageOrientationUp];
    return newImage;
}

@end
