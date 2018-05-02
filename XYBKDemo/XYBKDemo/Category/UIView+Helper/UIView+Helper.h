//
//  UIView+Helper.h
//  MingDuoHotelApp
//
//  Created by 陈晓 on 2018/4/8.
//  Copyright © 2018年 limengyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)
/**
 *  UIView
 *  直接设定位置的拓展
 *  size     大小
 *  left     左距
 *  right    右距
 *  top      上距
 *  bottom   下距
 *  centerX  中心X
 *  centerY  中心Y
 *  width    宽度
 *  height   高度
 */

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end
