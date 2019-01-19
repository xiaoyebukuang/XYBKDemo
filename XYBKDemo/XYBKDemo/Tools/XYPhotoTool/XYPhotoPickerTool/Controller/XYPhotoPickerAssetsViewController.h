//
//  XYPhotoPickerAssetsViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoRootViewController.h"
#import "XYPhotoPickerGroup.h"
#import "XYPhotoToolMacros.h"
@interface XYPhotoPickerAssetsViewController : XYPhotoRootViewController

/** 最大选择数 */
@property (nonatomic, assign) NSInteger maxCount;
/** 赋值group */
@property (nonatomic ,strong) XYPhotoPickerGroup *pickerGroup;
/** 相册类型 */
@property (nonatomic, assign) PHAssetCollectionSubtype subtype;

@end
