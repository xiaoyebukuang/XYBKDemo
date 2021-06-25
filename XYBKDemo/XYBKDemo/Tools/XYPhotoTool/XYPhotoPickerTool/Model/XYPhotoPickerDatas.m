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
- (void)loadAlbumGroupCompletionHandler:(void(^)(NSArray <XYPhotoPickerGroup *>* group))callBack{
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
- (void)getPhoto:(void(^)(NSArray <XYPhotoPickerGroup *>* group))callBack {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /**
         获得所有的自定义相簿
         PHAssetCollectionTypeAlbum      = 1,//从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
         PHAssetCollectionTypeSmartAlbum = 2,//经由相机得来的相册
         PHAssetCollectionTypeMoment     = 3,//Photos 为我们自动生成的时间分组的相册
         */
        
        /**
         PHAssetCollectionSubtypeAlbumRegular               //用户自己创建的相册
         PHAssetCollectionSubtypeAlbumSyncedEvent //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。然而，在iTunes 12 以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
         PHAssetCollectionSubtypeAlbumSyncedFaces //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
         PHAssetCollectionSubtypeAlbumSyncedAlbum //做了 AlbumSyncedEvent 应该做的事
         PHAssetCollectionSubtypeAlbumImported //从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。
         PHAssetCollectionSubtypeAlbumMyPhotoStream //用户的 iCloud 照片流
         PHAssetCollectionSubtypeAlbumCloudShared //用户使用 iCloud 共享的相册
         PHAssetCollectionSubtypeSmartAlbumGeneric //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。由于本人的 iPhoto 已被 Photos 替代，无法验证。不过，在我的 iPad mini 上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
         PHAssetCollectionSubtypeSmartAlbumPanoramas        //全景照片
         PHAssetCollectionSubtypeSmartAlbumVideos           //视频
         PHAssetCollectionSubtypeSmartAlbumFavorites        //个人收藏
         PHAssetCollectionSubtypeSmartAlbumTimelapses       //延时摄影
         PHAssetCollectionSubtypeSmartAlbumAllHidden        //已隐藏
         PHAssetCollectionSubtypeSmartAlbumRecentlyAdded    //最近添加
         PHAssetCollectionSubtypeSmartAlbumBursts           //连拍快照
         PHAssetCollectionSubtypeSmartAlbumSlomoVideos      //慢动作
         PHAssetCollectionSubtypeSmartAlbumUserLibrary      //相机胶卷
         PHAssetCollectionSubtypeSmartAlbumSelfPortraits    //PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0) 自拍
         PHAssetCollectionSubtypeSmartAlbumScreenshots      //PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0) 屏幕快照
         PHAssetCollectionSubtypeSmartAlbumDepthEffect      //PHOTOS_AVAILABLE_IOS_TVOS(10_2, 10_1)景深效果
         PHAssetCollectionSubtypeSmartAlbumLivePhotos       //PHOTOS_AVAILABLE_IOS_TVOS(10_3, 10_2)live Photo
         PHAssetCollectionSubtypeSmartAlbumAnimated         //PHOTOS_AVAILABLE_IOS_TVOS(11_0, 11_0) = 214,
         PHAssetCollectionSubtypeSmartAlbumLongExposures PHOTOS_AVAILABLE_IOS_TVOS(11_0, 11_0) =
         PHAssetCollectionSubtypeAny                        //包含所有类型
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
                // 同步获得图片, 只会返回1张图片
                PHImageRequestOptions *options = [XYPhotoPickerDatas getPHImageRequestOptionsSynchronous:YES];
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
                case PHAssetCollectionSubtypeAlbumImported:
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

/** 遍历相簿分组的全部图片 */
- (void)fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection callBack:(void(^)(NSArray <PHAsset *>* assets))callBack {
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
    });    
}
/** 获取PHAsset指定大小的图片 */
- (void)requestImageForAsset:(PHAsset *)asset
                    withSize:(CGSize)size
                    callBack:(void(^)(UIImage *image))callBack {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
    PHImageRequestOptions *options = [XYPhotoPickerDatas getPHImageRequestOptionsSynchronous:YES];
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:newSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        callBack(result);
    }];
}
/** 获取PHAsset指定大小的图片并缓存 */
- (void)cachingImageForAsset:(PHAsset *)asset
                  targetSize:(CGSize)size
                    callBack:(void(^)(UIImage *image))callBack {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
    PHImageRequestOptions *options = [XYPhotoPickerDatas getPHImageRequestOptionsSynchronous:NO];
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:newSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        callBack(result);
    }];
//    [((PHCachingImageManager *)[PHCachingImageManager defaultManager])startCachingImagesForAssets:@[asset] targetSize:newSize contentMode:PHImageContentModeAspectFill options:nil];
}
/** 获取PHAsset全屏的图片数组 */
- (void)getImagesFromPHAsset:(NSArray *)assetArr callBack:(void(^)(NSArray <UIImage *>* images))callBack {
    NSMutableArray *images = [NSMutableArray array];
    // 同步获得图片, 只会返回1张图片
    PHImageRequestOptions *options = [XYPhotoPickerDatas getPHImageRequestOptionsSynchronous:YES];
    CGFloat scale = [UIScreen mainScreen].scale;
    for (PHAsset *asset in assetArr) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(MAIN_SCREEN_WIDTH*scale, MAIN_SCREEN_HEIGHT*scale) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    [images addObject:result];
                }
            }];
        } else if ([asset isKindOfClass:[UIImage class]]) {
            [images addObject:asset];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        callBack(images);
    });
}
+ (PHImageRequestOptions *)getPHImageRequestOptionsSynchronous:(BOOL)synchronous {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    options.synchronous = synchronous;
    return options;
}
/** 存储相册 */
- (void)loadImageFinished:(UIImage *)image callBack:(void(^_Nullable)(BOOL success, NSError * _Nullable error))callBack {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
         PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
     } completionHandler:^(BOOL success, NSError * _Nullable error) {
         callBack(success, error);
    }];
}

@end
