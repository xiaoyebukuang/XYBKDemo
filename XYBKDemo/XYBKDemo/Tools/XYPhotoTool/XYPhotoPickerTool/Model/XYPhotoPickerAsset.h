//
//  XYPhotoPickerAsset.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYPhotoToolMacros.h"
@interface XYPhotoPickerAsset : NSObject

@property (nonatomic, strong) PHAsset *asset;
/** 默认图 */
@property (nonatomic, strong) UIImage *defaultImage;
/** 缩略图 */
@property (nonatomic, strong) UIImage *thumbImage;
/** 高清图 */
@property (nonatomic, strong) UIImage *image;
@end
