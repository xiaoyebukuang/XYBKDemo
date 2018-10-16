//
//  XYPhotoBrowserModel.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPhotoBrowserModel : NSObject
/** 自动适配以下几种数据（NSURL  UIImage  NSString） */
@property (nonatomic, strong) id photoObj;
/** URL地址 */
@property (nonatomic, strong) NSURL *photoURL;
/** 图片URL地址Str */
@property (nonatomic, copy) NSString *photoURLStr;
/** 原图或全屏图，也就是要显示的图 */
@property (nonatomic, strong) UIImage *photoImage;
/** 缩略图 */
//@property (nonatomic, strong) UIImage *thumbImage;
/** 传入一个图片对象，可以是URL/UIImage/NSString，返回一个实例 */
- (instancetype)initWithObj:(id)imageObj;

@end
