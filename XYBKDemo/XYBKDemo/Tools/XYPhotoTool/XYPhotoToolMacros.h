//
//  XYPhotoToolMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef XYPhotoToolMacros_h
#define XYPhotoToolMacros_h

/** 单元格 最小行间距 scrollView滑动之间的间距 */
static CGFloat const XYColletionViewLineSpacing = 20;
/** 单元格 最小列间距 */
static CGFloat const XYColletionViewInteritemSpacing = 0;
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

/** 完成通知 */
static NSString *PICKER_TAKE_DONE = @"PICKER_TAKE_DONE";
/** 相册常用类 */
#import "XYPhotoPickerDatas.h"

#endif /* XYPhotoToolMacros_h */
