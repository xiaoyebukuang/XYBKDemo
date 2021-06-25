//
//  XYPhotoBrowserViewController.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 相册浏览器 */
@interface XYPhotoBrowserViewController : UIViewController
/** 原数组 */
@property (nonatomic ,strong) NSArray *photosArr;

/** 当前的页码 */
@property (nonatomic ,assign) NSInteger currentPage;

@end
