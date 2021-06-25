//
//  XYPhotoPickerDatas.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "XYPhotoPickerGroup.h"
@interface XYPhotoPickerDatas : NSObject

/**
 *  获取单例
 */
+ (instancetype)defaultPicker;

/**
 获取所有的相簿

 @param callBack 获取图片组，返回array<XYPhotoPickerGroup *>
 */
- (void)loadAlbumGroupCompletionHandler:(void(^)(NSArray <XYPhotoPickerGroup *>* group))callBack;

/**
 遍历相簿分组的全部图片

 @param assetCollection 相簿
 @param callBack 获取图片组，返回array<PHAsset *>
 */
- (void)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                            callBack:(void(^)(NSArray <PHAsset *>* assets))callBack;

/**
 获取PHAsset指定大小的图片

 @param asset 指定PHAsset
 @param size size
 @param callBack 获取图片，返回Image
 */
- (void)requestImageForAsset:(PHAsset *)asset
                    withSize:(CGSize)size
                    callBack:(void(^)(UIImage *image))callBack;

/**
 获取PHAsset指定大小的图片并缓存

 @param asset 指定PHAsset
 @param size size
 @param callBack 回调
 */
- (void)cachingImageForAsset:(PHAsset *)asset
                  targetSize:(CGSize)size
                    callBack:(void(^)(UIImage *image))callBack;

/**
 获取PHAsset全屏的图片数组

 @param assetArr PHAsset数组
 @param callBack 图片数组，返回array<UIImage *>
 */
- (void)getImagesFromPHAsset:(NSArray *)assetArr
                    callBack:(void(^)(NSArray <UIImage *>* images))callBack;


/** 存储相册 */
- (void)loadImageFinished:(UIImage *)image callBack:(void(^_Nullable)(BOOL success, NSError * _Nullable error))callBack;
@end
