//
//  XYPhotoBrowserImageView.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYPhotoBrowserImageViewDelegate <NSObject>

@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView longTapDetected:(UITouch *)touch;

@end
@interface XYPhotoBrowserImageView : UIImageView
@property (nonatomic, weak) id <XYPhotoBrowserImageViewDelegate> tapDelegate;
- (void)removeScaleBigTap;
@end
