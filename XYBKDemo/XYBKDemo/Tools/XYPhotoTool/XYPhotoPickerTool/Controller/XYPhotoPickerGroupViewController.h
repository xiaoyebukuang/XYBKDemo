//
//  XYPhotoPickerGroupViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "RootViewController.h"
#import "XYPhotoPickerViewController.h"

@interface XYPhotoPickerGroupViewController : RootViewController
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
