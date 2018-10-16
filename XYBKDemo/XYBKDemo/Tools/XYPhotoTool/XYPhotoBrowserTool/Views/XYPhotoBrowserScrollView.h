//
//  XYPhotoBrowserScrollView.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPhotoBrowserModel.h"
@class XYPhotoBrowserScrollView;

@protocol XYPhotoBrowserScrollViewDelegate <NSObject>
@optional
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(XYPhotoBrowserScrollView *)photoScrollView;
//双击
- (void) pickerPhotoScrollViewDidDoubleClick:(XYPhotoBrowserScrollView *)photoScrollView;
//长按
- (void) pickerPhotoScrollViewDidLongPressed:(XYPhotoBrowserScrollView *)photoScrollView;
@end

@interface XYPhotoBrowserScrollView : UIScrollView


@property (nonatomic ,weak) id<XYPhotoBrowserScrollViewDelegate>photoScrollViewDelegate;

@property (nonatomic ,strong) XYPhotoBrowserModel *photoModel;


@end
