//
//  XYBannerView.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYBannerView;

@protocol XYBannerViewDelegate <NSObject>

-(void)didSelectIndex:(NSInteger)index bannerView:(XYBannerView *)bannerView;

@end

@interface XYBannerView : UIView

/** 时间time */
@property (nonatomic ,assign) NSTimeInterval duration;
/** 默认图 */
@property (nonatomic, copy) NSString *placeholderStr;
/** 图片模式 */
@property (nonatomic, assign) UIViewContentMode contentMode;

@property (nonatomic, weak) id <XYBannerViewDelegate>delegate;

/** 刷新视图 */
- (void)reloadViewWithArr:(NSArray *)imagesArr isRunning:(BOOL)isRunning;
/** 取消计时器 */
- (void)stopTimer;
/** 滑动指定页码 */
- (void)scrollToPage:(NSInteger)page;
@end
