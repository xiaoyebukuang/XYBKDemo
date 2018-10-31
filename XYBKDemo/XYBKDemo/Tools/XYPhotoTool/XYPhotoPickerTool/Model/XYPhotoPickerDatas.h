//
//  XYPhotoPickerDatas.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
typedef void(^PickerDatasCallBack)(id obj);

@interface XYPhotoPickerDatas : NSObject

/**
 *  获取单例
 */
+ (instancetype)defaultPicker;

/**
 获取所有的相簿

 @param callBack 获取图片组，返回array<XYPhotoPickerGroup *>
 */
- (void)getAllGroupWithPhotos:(PickerDatasCallBack)callBack;

/**
 遍历相簿中的全部图片

 @param assetCollection 相簿
 @param callBack 获取图片组，返回array<XYPhotoPickerGroup *>
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                     pickerDatasCallBack:(PickerDatasCallBack)callBack;

/**
 获取PHAsset指定大小的图片

 @param asset 指定PHAsset
 @param size size
 @return image
 */
- (UIImage *)getImageFromPHAsset:(PHAsset *)asset
                        withSize:(CGSize)size;


/**
 获取PHAsset全屏的图片数组

 @param assetArr PHAsset数组
 @return 图片数组
 */
- (NSArray *)getImagesFromPHAsset:(NSArray *)assetArr;

@end