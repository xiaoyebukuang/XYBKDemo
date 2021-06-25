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
/** 获取分享比例的图片 */
- (UIImage *)getShareImage;
/** 压缩图片到指定size */
- (UIImage*)originImageScaleToSize:(CGSize)size;
- (UIImage*)originImageScaleToSize:(CGSize)size scale:(CGFloat)scale;
/** 网络图片存入沙盒并返回（针对tabBarIcon使用）*/
+ (UIImage *)tabBarItemImageUrl_2X:(NSString *)imageUrl_2X imageUrl_3X:(NSString *)imageUrl_3X tabIndex:(NSInteger)tabIndex;
/** 获取二维码图片 */
+ (UIImage *)getQRCodeImageWithQRCode:(NSString *)code;
/** 获取不变形的图片 */
+ (UIImage *)getStretchableImageWithImageName:(NSString *)imageName;

/** 获取图片的某一点的颜色 */
- (UIColor*)colorAtPixel:(CGPoint)point;


@end
