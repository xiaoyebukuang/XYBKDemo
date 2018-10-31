//
//  XYPhotoPickerViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RootViewController.h"

// 状态组
typedef NS_ENUM(NSInteger , PickerViewShowStatus) {
    PickerViewShowStatusGroup = 0, //默认相册组
    PickerViewShowStatusCameraRoll //所有照片
};

@interface XYPhotoPickerViewController : RootViewController
/**
 需要push到的内容控制器
 默认为Groups
 */
@property (nonatomic ,assign) PickerViewShowStatus status;

/**
 每次选择图片的最大数，默认最大数是9
 */
@property (nonatomic ,assign) NSInteger maxCount;

@end
