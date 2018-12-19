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
 异步获取相册中第一张图片

 @param assetCollection 相册
 @param handler 回调
 */
- (void)getGroupNormalPhoto:(PHAssetCollection *)assetCollection
                   complete:(void(^)(UIImage *image))handler;



/**
 遍历指定相簿中的图片

 @param subtype 相簿类型
 @param callBack 回调
 */
- (void)enumeratePHAssetCollectionSubtype:(PHAssetCollectionSubtype)subtype
                      pickerDatasCallBack:(PickerDatasCallBack)callBack;

/**
 遍历相簿中的全部图片
 
 @param assetCollection 相簿
 @param callBack 获取图片组，返回array<XYPhotoPickerGroup *>
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                     pickerDatasCallBack:(PickerDatasCallBack)callBack;

/**
 获取指定大小的图片

 @param asset 数据源
 @param synchronous 是否同步
 @param size size
 @param handler 回调
 */
- (void)getImageFromPHAsset:(PHAsset *)asset synchronous:(BOOL)synchronous size:(CGSize)size complete:(void(^)(UIImage *image))handler;

/**
 获取PHAsset全屏的图片数组

 @param assetArr PHAsset数组
 @param callBack 回调
 */
- (void)getImagesFromPHAsset:(NSArray *)assetArr pickerDatasCallBack:(PickerDatasCallBack)callBack;

@end
