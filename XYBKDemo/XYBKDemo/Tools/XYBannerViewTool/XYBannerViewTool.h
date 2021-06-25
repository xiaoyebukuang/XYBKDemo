//
//  XYBannerViewTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/12.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYBannerViewTool;

@protocol XYBannerViewToolDelegate <NSObject>

@optional
-(void)bannerViewToolEvent:(NSInteger)index imageView:(UIImageView *)imageView;

-(void)bannerViewToolEvent:(NSInteger)index imageView:(UIImageView *)imageView bannerViewTool:(XYBannerViewTool *)bannerViewTool;

@end

@interface XYBannerViewTool : UIView
/** 时间time 默认为5 */
@property (nonatomic ,assign) NSTimeInterval duration;
/** 加载默认默认图片 */
@property (nonatomic, copy) NSString *placeholderStr;
/** 图片模式 */
@property (nonatomic, assign) UIViewContentMode contentMode;
/** 水平间距 */
@property (nonatomic, assign) CGFloat levelSpace;
@property (nonatomic, assign) BOOL masksToBounds;
/** 是否展示image */
@property (nonatomic, assign) BOOL showImage;

@property (nonatomic, weak) id <XYBannerViewToolDelegate>delegate;
/** 初始化，滚动条距离底部距离 */
- (instancetype)initWithBottom:(CGFloat)bottom_height;
/** 刷新视图 */
- (void)reloadViewWithArr:(NSArray *)imagesArr isRunning:(BOOL)isRunning;
/** 停止计时器 */
- (void)stopTimer;
/** 滑动到指定页码 */
- (void)scrollToPage:(NSInteger)page;

@end
