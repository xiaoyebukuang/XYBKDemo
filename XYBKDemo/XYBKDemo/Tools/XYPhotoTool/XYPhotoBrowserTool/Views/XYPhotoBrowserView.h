//
//  XYPhotoBrowserView.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYPhotoBrowserViewDelegate <NSObject>

@optional
- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;

@end

@interface XYPhotoBrowserView : UIView

@property (nonatomic, weak) id <XYPhotoBrowserViewDelegate> tapDelegate;

@end
