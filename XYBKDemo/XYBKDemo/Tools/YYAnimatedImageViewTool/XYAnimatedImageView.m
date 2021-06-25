//
//  XYAnimatedImageView.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYAnimatedImageView.h"
#import "FLAnimatedImage.h"

@implementation XYAnimatedImageView
- (void)setXy_imageURL:(NSURL *)xy_imageURL {
    NSString *urlStr = xy_imageURL.absoluteString;
    if ([self.xy_imageUrlStr isEqualToString:urlStr] && self.downLoadSuc) {
        return;
    }
    self.downLoadSuc = NO;
    self.xy_imageUrlStr = urlStr;
    if ([urlStr hasSuffix:@".gif"]) {
        NSData *imageData = [self imageDataFromDiskCacheWithKey:urlStr];
        if (imageData.length > 0) {
            self.downLoadSuc = YES;
            FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc]initWithAnimatedGIFData:imageData];
            self.animatedImage = animatedImage;
        } else {
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:xy_imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (image && data.length > 0) {
                    self.downLoadSuc = YES;
                    FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc]initWithAnimatedGIFData:data];
                    self.animatedImage = animatedImage;
                    SDImageCache *imageCache = [[SDWebImageManager sharedManager]imageCache];
                    [imageCache storeImageDataToDisk:data forKey:urlStr];
                }
            }];
        }
    } else {
        [self sd_setImageWithURL:xy_imageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                self.downLoadSuc = YES;
            }
        }];
    }
}
- (NSData *)imageDataFromDiskCacheWithKey:(NSString *)key {
    SDImageCache *imageCache = [[SDWebImageManager sharedManager]imageCache];
    NSString *path = [imageCache cachePathForKey:key];
    return [NSData dataWithContentsOfFile:path];
}

@end
