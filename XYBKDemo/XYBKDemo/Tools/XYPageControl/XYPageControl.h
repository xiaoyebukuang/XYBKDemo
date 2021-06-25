//
//  XYPageControl.h
//  cwz51
//
//  Created by 陈晓 on 2018/12/22.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPageControl : UIControl

/** 总页码 */
@property(nonatomic, assign) NSInteger numberOfPages;
/** 当前页码 */
@property(nonatomic, assign) NSInteger currentPage;

/** 未选中颜色 默认E6E6E6 */
@property(nonatomic, strong) UIColor *pageIndicatorTintColor;
/** 选中颜色 默认FF5400 */
@property(nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/** 当前选中的宽度 默认12 */
@property (nonatomic, assign) CGFloat currentWidth;
/** 当前选中的高度 默认5*/
@property (nonatomic, assign) CGFloat currentHeight;
/** 默认的宽度  默认6*/
@property (nonatomic, assign) CGFloat normalWidth;
/** 间隙  默认5 */
@property (nonatomic, assign) CGFloat space;

@end
