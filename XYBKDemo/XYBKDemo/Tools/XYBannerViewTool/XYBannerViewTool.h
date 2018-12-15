//
//  XYBannerViewTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/12.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XYBannerViewToolDelegate <NSObject>

-(void)bannerViewToolEvent:(NSInteger)index;

@end


@interface XYBannerViewTool : UIView
/** 时间time */
@property (nonatomic ,assign) NSTimeInterval duration;
/** 默认图 */
@property (nonatomic, copy) NSString *placeholderStr;
/** 图片模式 */
@property (nonatomic, assign) UIViewContentMode contentMode;

@property (nonatomic, weak) id <XYBannerViewToolDelegate>delegate;

/** 刷新视图 */
- (void)reloadViewWithArr:(NSArray *)imagesArr isRunning:(BOOL)isRunning;

- (void)stopTimer;


@end
