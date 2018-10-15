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

@property (nonatomic, weak) id <XYBannerViewToolDelegate>delegate;

- (void)reloadViewWithArr:(NSArray *)imagesArr isRunning:(BOOL)isRunning;

- (void)stopTimer;


@end
