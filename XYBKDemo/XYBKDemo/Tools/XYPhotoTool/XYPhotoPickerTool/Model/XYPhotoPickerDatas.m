//
//  XYPhotoPickerDatas.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerDatas.h"
#import "XYPhotoToolMacros.h"
#import "XYPhotoPickerGroup.h"
@implementation XYPhotoPickerDatas

/** 获取单例 */
+ (instancetype) defaultPicker{
    static XYPhotoPickerDatas *photoPickerDatas = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        photoPickerDatas = [[self alloc]init];
    });
    return photoPickerDatas;
}

/** 获取所有的相簿 */
- (void)getAllGroupWithPhotos:(PickerDatasCallBack)callBack; {
    /** 第一次获取权限 */
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self getPhoto:callBack];
            }
        }];
    } else {
        [self getPhoto:callBack];
    }
}
- (void)getPhoto:(PickerDatasCallBack)callBack {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /**
         获得所有的自定义相簿
         PHAssetCollectionTypeAlbum      = 1,//从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
         PHAssetCollectionTypeSmartAlbum = 2,//经由相机得来的相册
         PHAssetCollectionTypeMoment     = 3,//Photos 为我们自动生成的时间分组的相册
         */
        
        /**
         case AlbumRegular //用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
         case AlbumSyncedEvent //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。然而，在iTunes 12 以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
         case AlbumSyncedFaces //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
         case AlbumSyncedAlbum //做了 AlbumSyncedEvent 应该做的事
         case AlbumImported //从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。
         case AlbumMyPhotoStream //用户的 iCloud 照片流
         case AlbumCloudShared //用户使用 iCloud 共享的相册
         case SmartAlbumGeneric //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。由于本人的 iPhoto 已被 Photos 替代，无法验证。不过，在我的 iPad mini 上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
         case SmartAlbumPanoramas //相机拍摄的全景照片
         case SmartAlbumVideos //相机拍摄的视频
         case SmartAlbumFavorites //收藏文件夹
         case SmartAlbumTimelapses //延时视频文件夹，同时也会出现在视频文件夹中
         case SmartAlbumAllHidden //包含隐藏照片或视频的文件夹
         case SmartAlbumRecentlyAdded //相机近期拍摄的照片或视频
         case SmartAlbumBursts //连拍模式拍摄的照片，在 iPad mini 上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
         case SmartAlbumSlomoVideos //Slomo 是 slow motion 的缩写，高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。不过我的 iPad mini 不支持，没法验证。
         case SmartAlbumUserLibrary //这个命名最神奇了，就是相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
         case Any //包含所有类型
         */
        NSMutableArray *group = [NSMutableArray array];
        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        //遍历所有的自定义相簿
        for (PHAssetCollection *assetCollection in assetCollections) {
            //获得某个相簿中的所有PHAsset对象
            PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            XYPhotoPickerGroup *groupModel = [[XYPhotoPickerGroup alloc]init];
            groupModel.assetCollection = assetCollection;
            groupModel.groupName = assetCollection.localizedTitle;
            groupModel.assetSubtype = assetCollection.assetCollectionSubtype;
            groupModel.assetsCount = assets.count;
            if (assets.count > 0) {
                PHAsset *asset = assets.firstObject;
                PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
                options.resizeMode = PHImageRequestOptionsResizeModeFast;
                // 同步获得图片, 只会返回1张图片
                options.synchronous = YES;
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(kAlbumRowWidth, kAlbumRowHeight) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    groupModel.thumbImage = result;
                }];
            } else {
                groupModel.thumbImage = [UIImage imageNamed:@"blank"];
            }
            switch (assetCollection.assetCollectionSubtype) {
                case PHAssetCollectionSubtypeSmartAlbumUserLibrary:
                    [group insertObject:groupModel atIndex:0];
                    break;
                case PHAssetCollectionSubtypeSmartAlbumFavorites:
                case PHAssetCollectionSubtypeSmartAlbumRecentlyAdded:
                case PHAssetCollectionSubtypeSmartAlbumSelfPortraits:
                case PHAssetCollectionSubtypeSmartAlbumScreenshots:
                case PHAssetCollectionSubtypeSmartAlbumBursts:
                case PHAssetCollectionSubtypeSmartAlbumPanoramas:
                    [group addObject:groupModel];
                    break;
                default:
                    break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(group);
        });
    });
}

/** 遍历相簿中的全部图片 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection pickerDatasCallBack:(PickerDatasCallBack)callBack {
    /**
     //resizeMode:PHImageRequestOptionsResizeMode  自定义设置图片的大小 枚举类型*
     PHImageRequestOptionsResizeMode:*
     PHImageRequestOptionsResizeModeNone = 0, //保持原size
     PHImageRequestOptionsResizeModeFast, //高效、但不保证图片的size为自定义size
     PHImageRequestOptionsResizeModeExact, //严格按照自定义size
     */
    /**
     //resizeMode:PHImageRequestOptionsDeliveryMode
    PHImageRequestOptionsDeliveryModeOpportunistic//根据我self.options.synchronous判断返回结果是一个抑或多个
    PHImageRequestOptionsDeliveryModeHighQualityFormat //制定的同步返回一个结果，返回的图片质量是比我们设定的size会好一点(实际上与PHImageRequestOptions的resizeMode枚举相关)
    PHImageRequestOptionsDeliveryModeFastFormat//仅返回一次，效率较高之余获得的图质量不太好
    */
    
    NSMutableArray *assetsArray = [NSMutableArray array];
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            // 从asset中获得图片
            [assetsArray addObject:asset];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        callBack(assetsArray);
    });
}
/** 获取PHAsset指定大小的图片 */
- (UIImage *)getImageFromPHAsset:(PHAsset *)asset withSize:(CGSize)size {
    NSMutableArray *images = [NSMutableArray array];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        [images addObject:result];
    }];
    if (images.count > 0) {
        return [images firstObject];
    }
    return nil;
}
/** 获取PHAsset全屏的图片数组 */
- (NSArray *)getImagesFromPHAsset:(NSArray *)assetArr {
    NSMutableArray *images = [NSMutableArray array];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    for (PHAsset *asset in assetArr) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [images addObject:result];
        }];
    }
    return images;
}

@end