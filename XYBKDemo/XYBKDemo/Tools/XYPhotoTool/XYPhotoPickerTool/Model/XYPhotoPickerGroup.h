//
//  XYPhotoPickerGroup.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
/** 相簿组 */
@interface XYPhotoPickerGroup : NSObject
/** 组名 */
@property (nonatomic, copy) NSString *groupName;
/** 缩略图 默认为50 */
@property (nonatomic, strong) UIImage *thumbImage;
/** 组里面的图片个数 */
@property (nonatomic, assign) NSInteger assetsCount;

/** 相册类型 */
@property (nonatomic, assign) PHAssetCollectionSubtype assetSubtype;
/** 相册 */
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
