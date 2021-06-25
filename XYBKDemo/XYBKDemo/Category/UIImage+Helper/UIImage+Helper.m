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
/** 获取分享比例的图片 */
- (UIImage *)getShareImage {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageScale = 1.25;
    CGRect dianRect;
    CGFloat currentScale = self.size.width/self.size.height;
    if (currentScale >= imageScale) {
        //宽度比例大，以高度为基准
        CGFloat fixelW = CGImageGetWidth(self.CGImage);
        CGFloat fixelH = CGImageGetHeight(self.CGImage);
        
        CGFloat width = fixelH*imageScale;
        CGFloat heigth = fixelH;
        dianRect = CGRectMake((fixelW - width)/2, (fixelH - heigth)/2, width, heigth);
    } else {
        //宽度比例小，以宽度为基准
        CGFloat fixelW = CGImageGetWidth(self.CGImage);
        CGFloat fixelH = CGImageGetHeight(self.CGImage);
        
        CGFloat width = fixelW;
        CGFloat heigth = fixelW/imageScale;
        dianRect = CGRectMake((fixelW - width)/2, (fixelH - heigth)/2, width, heigth);
    }
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:UIImageOrientationUp];
    return newImage;
}
/** 压缩图片到指定size */
- (UIImage*)originImageScaleToSize:(CGSize)size {
    return  [self originImageScaleToSize:size scale:[UIScreen mainScreen].scale];
}
- (UIImage*)originImageScaleToSize:(CGSize)size scale:(CGFloat)scale {
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/** 网络图片存入沙盒并返回（针对tabBarIcon使用） */
+ (UIImage *)tabBarItemImageUrl_2X:(NSString *)imageUrl_2X imageUrl_3X:(NSString *)imageUrl_3X tabIndex:(NSInteger)tabIndex {
    if (imageUrl_3X.length == 0) {
        return nil;
    }
    //获取保存图片的名称
    int screen_scale = (int)[UIScreen mainScreen].scale;
    //获取保存图片的名称
    NSArray *stringArr = [imageUrl_3X componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    NSString *name = [[imageName componentsSeparatedByString:@"."] firstObject];
    imageName = [NSString stringWithFormat:@"%@@%dx.png",name,screen_scale];
    //获取缓存地址
    NSString *iconFilePath = [PATH_CACHE stringByAppendingPathComponent:@"tabbarIcon"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExit = [fileManager fileExistsAtPath:iconFilePath];
    if(!isExit) {
        NSError *error;
        [fileManager createDirectoryAtPath:iconFilePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    NSString *fullPath = [iconFilePath stringByAppendingPathComponent:imageName];
    // 判断文件是否已存在，存在直接读取
    UIImage *tabImage;
    if ([fileManager fileExistsAtPath:fullPath]) {
        tabImage = [UIImage imageWithContentsOfFile:fullPath];
    } else {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl_3X]];
        UIImage *image = [UIImage imageWithData:data];
        CGFloat size_width = image.size.width/3*screen_scale;
        CGFloat size_height = image.size.height/3*screen_scale;
        CGSize image_size = CGSizeMake(size_width, size_height);
        image = [image originImageScaleToSize:image_size scale:1];
        // 将image写入沙河
        if ([UIImagePNGRepresentation(image) writeToFile:fullPath atomically:YES]) {
            tabImage = [UIImage imageWithContentsOfFile:fullPath];
        }
    }
    if (tabImage) {
        return [UIImage imageWithCGImage:tabImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    }
    return nil;
}
+ (UIImage *)getQRCodeImageWithQRCode:(NSString *)code {
    //1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    // 3. 将字符串转换成NSData
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 6. 将CIImage转换成UIImage，并显示于imageView上 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:180];
}
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)getStretchableImageWithImageName:(NSString *)imageName {
    UIImage *bgImage = [UIImage imageNamed:imageName];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width/2 topCapHeight:bgImage.size.height/2];
    return bgImage;
}


- (UIColor*)colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if(!CGRectContainsPoint(CGRectMake(0.0f,0.0f,self.size.width,self.size.height), point)) {
        return [UIColor clearColor];
    }
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage =self.CGImage;
    NSUInteger width =self.size.width;
    NSUInteger height =self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel =4;
    int bytesPerRow = bytesPerPixel*1;
    NSUInteger bitsPerComponent =8;
    unsigned char pixelData[4] = {0,0,0,0};
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f,0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red= (CGFloat)pixelData[0] /255.0f;
    CGFloat green = (CGFloat)pixelData[1] /255.0f;
    CGFloat blue= (CGFloat)pixelData[2] /255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] /255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
