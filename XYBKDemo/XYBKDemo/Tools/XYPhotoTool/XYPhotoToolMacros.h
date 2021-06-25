//
//  XYPhotoToolMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef XYPhotoToolMacros_h
#define XYPhotoToolMacros_h

// 状态组
typedef NS_ENUM(NSInteger , PickerViewShowStatus) {
    PickerViewShowStatusGroup = 0, //默认相册组
    PickerViewShowStatusCameraRoll //所有照片
};

/** 图片选择完成回调 */
typedef void(^PhotoPickerAssetsCallBlock)(NSArray *imagesArray);
/** 图片选中回调 */
typedef void(^XYNewPhotoPickerSelectedBlock)(BOOL isSelected);

/** 单元格 最小行间距 scrollView滑动之间的间距 */
static CGFloat const XYColletionViewLineSpacing = 20;
/** 单元格 最小列间距 */
static CGFloat const XYColletionViewInteritemSpacing = 0.0f;
/** 动画时间 */
static CGFloat const XYScrollViewAnimations = 0.3f;


/** 相簿组默认size */
/** 默认缩略图的高度 */
static CGFloat const kAlbumRowHeight = 50.0f;
/** 默认缩略图的宽度 */
static CGFloat const kAlbumRowWidth = 50.0f;


/** 某一相簿默认size */
/** 默认缩略图的高度 */
static CGFloat const kAssetsRowHeight = 108.0f;
/** 默认缩略图的宽度 */
static CGFloat const kAssetsRowWidth = 108.0f;


/** 选择图片+预览页面底部高度 */
static CGFloat const kAssetsBottomHeight = 45.0f;

static CGFloat const kNewAssetsBottomHeight = 52.0f;

/** 图片选择完成通知 */
#define NOTIFICATION_PICKER_TAKE_DONE       @"NOTIFICATION_PICKER_TAKE_DONE"
/** 相册常用类 */
#import "XYPhotoPickerDatas.h"


#endif /* XYPhotoToolMacros_h */
