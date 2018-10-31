//
//  XYPhotoTransitionView.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/1.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYPhotoTransitionViewDelegate <NSObject>

/** 获取当前的图片在原始view中的位置 */
-(CGRect)getFrameWithCurrentPage:(NSInteger)currentPage sourceView:(UIView *)sourceView;

@end
@interface XYPhotoTransitionView : UIView

/** 原数组 */
@property (nonatomic ,strong) NSArray *photosArr;

/** 当前的页码 */
@property (nonatomic ,assign) NSInteger currentPage;


@property (nonatomic, weak) id<XYPhotoTransitionViewDelegate>delegate;


/**
 显示动画
 
 @param currentPage 当前的page
 @param image 当前的image
 @param photosArr 图片数组
 */
- (void)showPhotoBrowerViewWithCurrentPage:(NSInteger)currentPage
                                     image:(UIImage *)image
                                 photosArr:(NSArray *)photosArr;
@end
