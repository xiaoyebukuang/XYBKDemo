//
//  XYPhotoBrowserImageView.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoBrowserImageView.h"
@interface XYPhotoBrowserImageView()

@property (strong,nonatomic) UITapGestureRecognizer *scaleBigTap;

@end

@implementation XYPhotoBrowserImageView
#pragma mark -- init
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
        // 监听手势
        [self addGesture];
    }
    return self;
}
- (id)initWithImage:(UIImage *)image {
    if ((self = [super initWithImage:image])) {
        self.userInteractionEnabled = YES;
        // 监听手势
        [self addGesture];
    }
    return self;
}
- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
        self.userInteractionEnabled = YES;
        // 监听手势
        [self addGesture];
    }
    return self;
}
#pragma mark -- gesture监听手势
- (void)addGesture{
    self.contentMode = UIViewContentModeScaleAspectFit;
    //双击放大
    UITapGestureRecognizer *scaleBigTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    scaleBigTap.numberOfTapsRequired = 2;
    scaleBigTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:_scaleBigTap = scaleBigTap];
    //单击
    UITapGestureRecognizer *disMissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    disMissTap.numberOfTapsRequired = 1;
    disMissTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:disMissTap];
    // 只能有一个手势存在
    [disMissTap requireGestureRecognizerToFail:scaleBigTap];
    //长按
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
    [self addGestureRecognizer:longGesture];
}
#pragma mark -- gesture action
- (void)handleSingleTap:(UITouch *)touch {
    if ([_tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
        [_tapDelegate imageView:self singleTapDetected:touch];
}
- (void)handleDoubleTap:(UITouch *)touch {
    if ([_tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
        [_tapDelegate imageView:self doubleTapDetected:touch];
}
- (void)handleLongGesture:(UITouch *)touch{
    if ([_tapDelegate respondsToSelector:@selector(imageView:longTapDetected:)])
        [_tapDelegate imageView:self longTapDetected:touch];
}
- (void)removeScaleBigTap {
    [self.scaleBigTap removeTarget:self action:@selector(handleDoubleTap:)];
}
@end
