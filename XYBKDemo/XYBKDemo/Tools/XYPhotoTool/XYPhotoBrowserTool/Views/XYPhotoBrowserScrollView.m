//
//  XYPhotoBrowserScrollView.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoBrowserScrollView.h"
#import "XYPhotoBrowserView.h"
#import "XYPhotoToolMacros.h"
@interface XYPhotoBrowserScrollView()<XYPhotoBrowserViewDelegate, XYPhotoBrowserImageViewDelegate, UIScrollViewDelegate>
/** 最大缩放 */
@property (nonatomic, assign) CGFloat maxScale;
/** 最小缩放 */
@property (nonatomic, assign) CGFloat minScale;
/** imageView基size */
@property (nonatomic, assign) CGSize baseSize;
/** 是否放大 */
@property (nonatomic, assign) BOOL isBigScale;

@property (nonatomic, strong) XYPhotoBrowserView *photoBrowserView;

/** 进度条 */
@property (nonatomic ,strong) MBProgressHUD* progressView;
/** 设置进度 */
@property (nonatomic ,assign) CGFloat progress;

@property (nonatomic ,strong) id model;
@end


@implementation XYPhotoBrowserScrollView
#pragma mark -- init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor blackColor];
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.photoBrowserView];
    [self addSubview:self.photoBrowserImageView];
//    [self addSubview:self.progressView];
}
#pragma mark -- setData
- (void)reloadViewWithModel:(id)model placeholderImage:(UIImage *)placeholderImage {
    self.model = model;
    WeakSelf;
    if ([model isKindOfClass:[UIImage class]]) {
        //图片
        UIImage *image = model;
        self.progress = 1;
        self.photoBrowserImageView.image = image;
        [self displayImage];
    } else if ([model isKindOfClass:[NSString class]]) {
        //url
        NSString *urlStr = model;
        [self.progressView showAnimated:YES];
        self.photoBrowserImageView.image = placeholderImage;
        [weakSelf displayImage];
        NSURL *url = [NSURL URLWithString:urlStr];
        [self.photoBrowserImageView sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            [weakSelf setProgress:(double)receivedSize / expectedSize];
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakSelf.progress = 1.0;
            if (image) {
                weakSelf.photoBrowserImageView.image = image;
            }else{
                [self.photoBrowserImageView removeScaleBigTap];
            }
            [weakSelf displayImage];
        }];
    } else if ([model isKindOfClass:[PHAsset class]]) {
        self.photoBrowserImageView.image = nil;
        [MBProgressHUD showMessage:@"" ToView:self];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHAsset *asset = model;
            [[XYPhotoPickerDatas defaultPicker]cachingImageForAsset:asset targetSize:CGSizeMake(MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) callBack:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self];
                    self.photoBrowserImageView.image = image;
                });
            }];
        });
    }
}
/** 设置进度条 */
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (progress == 0) return ;
    if (progress / 1.0 != 1.0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress;
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView hideAnimated:YES];
        });
    }
}
/**  */
- (void)displayImage{
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    UIImage *img = self.photoBrowserImageView.image;
    if (img) {
        self.photoBrowserImageView.image = img;
        //设置缩放
        CGSize boundsSize = self.bounds.size;
        CGSize imageSize = img.size;
        //宽度缩放比例
        CGFloat xScale = boundsSize.width/imageSize.width;
        //高度缩放比例
        CGFloat yScale = boundsSize.height/imageSize.height;
        if (xScale < yScale) {
            //高度缩放不满屏，宽度缩放满屏
            self.photoBrowserImageView.contentMode = UIViewContentModeScaleAspectFit;
        }else{
            //高度缩放超屏，宽度缩放满屏
            self.photoBrowserImageView.contentMode = UIViewContentModeScaleAspectFill;
        }
        if (xScale > 1) {
            xScale = 1;
        }
        // Set
        self.minScale = 1;
        if (imageSize.height*xScale*2 < boundsSize.height) {
            self.maxScale = boundsSize.height/(imageSize.height*xScale);
        }else{
            self.maxScale = 2;
        }
        self.maximumZoomScale = self.maxScale;
        self.minimumZoomScale = self.minScale;
        self.zoomScale = self.minScale;
        self.photoBrowserImageView.frame = CGRectMake(0, 0, self.width, imageSize.height*xScale);
        self.baseSize = self.photoBrowserImageView.frame.size;
        self.contentSize = self.baseSize;
    }
    [self setNeedsLayout];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.photoBrowserImageView.frame;
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    if (!CGRectEqualToRect(self.photoBrowserImageView.frame, frameToCenter))
        self.photoBrowserImageView.frame = frameToCenter;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.photoBrowserImageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark -- XYPhotoBrowserViewViewDelegate
- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch {
    [self photoScrollViewDidSingleClick];
}
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch {
    CGPoint point = [touch locationInView:view];
    [self handleImageViewDoubleTap:point];
}
#pragma makr -- XYPhotoBrowserImageViewDelegate
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch {
    [self photoScrollViewDidSingleClick];
}
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [self handleImageViewDoubleTap:[touch locationInView:imageView]];
}
- (void)imageView:(UIImageView *)imageView longTapDetected:(UITouch *)touch {
    [self photoScrollViewDidLongPressed];
}
//单击实现
- (void)photoScrollViewDidSingleClick {
    if (self.photoScrollViewDelegate && [self.photoScrollViewDelegate respondsToSelector:@selector(pickerPhotoScrollViewDidSingleClick:)]) {
        [self.photoScrollViewDelegate performSelector:@selector(pickerPhotoScrollViewDidSingleClick:) withObject:self];
    }
}
//长按实现
- (void)photoScrollViewDidLongPressed {
    if ([self.photoScrollViewDelegate respondsToSelector:@selector(pickerPhotoScrollViewDidLongPressed:)]) {
        [self.photoScrollViewDelegate performSelector:@selector(pickerPhotoScrollViewDidLongPressed:) withObject:self];
    }
}
//双击实现
- (void)handleImageViewDoubleTap:(CGPoint)touchPoint {
    if ([self.photoScrollViewDelegate respondsToSelector:@selector(pickerPhotoScrollViewDidDoubleClick:)]) {
        [self.photoScrollViewDelegate performSelector:@selector(pickerPhotoScrollViewDidDoubleClick:) withObject:self];
    }
    CGSize boundsSize = self.bounds.size;
    if (!self.isBigScale||self.photoBrowserImageView.width <= boundsSize.width) {
        
        CGFloat maxPointX = 0;
        CGFloat maxPointY = 0;
        
        CGFloat contentOffsetX = 0;
        CGFloat contentOffsetY = 0;
        
        CGFloat maxSizeWidth = self.baseSize.width*self.maxScale;
        CGFloat maxSizeheight = self.baseSize.height*self.maxScale;
        
        maxPointX = touchPoint.x*self.maxScale;
        maxPointY = touchPoint.y*self.maxScale;
        
        if (maxPointX < boundsSize.width/2) {
            contentOffsetX = 0;
        }else if (maxPointX > boundsSize.width/2 && maxPointX < maxSizeWidth - boundsSize.width/2){
            contentOffsetX = maxPointX - boundsSize.width/2;
        }else{
            contentOffsetX = maxSizeWidth - boundsSize.width;
        }
        
        if (maxPointY < boundsSize.height/2) {
            contentOffsetY = 0;
        }else if (maxPointY > boundsSize.height/2 && maxPointY < maxSizeheight - boundsSize.height/2){
            contentOffsetY = maxPointY - boundsSize.height/2;
        }else{
            contentOffsetY = maxSizeheight - boundsSize.height;
        }
        self.isBigScale = YES;
        //放大
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:XYScrollViewAnimations];
        self.zoomScale = self.maxScale;
        [self setContentOffset:CGPointMake(contentOffsetX, contentOffsetY)];
        [UIView commitAnimations];
    }else{
        self.isBigScale = NO;
        //缩小
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:XYScrollViewAnimations];
        self.zoomScale = self.minScale;
        [UIView commitAnimations];
    }
}
#pragma mark -- setup
- (XYPhotoBrowserView *)photoBrowserView {
    if (!_photoBrowserView) {
        _photoBrowserView = [[XYPhotoBrowserView alloc] initWithFrame:self.bounds];
        _photoBrowserView.tapDelegate = self;
        _photoBrowserView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _photoBrowserView.backgroundColor = [UIColor clearColor];
    }
    return _photoBrowserView;
}
- (XYPhotoBrowserImageView *)photoBrowserImageView {
    if (!_photoBrowserImageView) {
        _photoBrowserImageView = [[XYPhotoBrowserImageView alloc] initWithFrame:self.bounds];
        _photoBrowserImageView.backgroundColor = [UIColor clearColor];
        _photoBrowserImageView.tapDelegate = self;
    }
    return _photoBrowserImageView;
}
- (MBProgressHUD *)progressView {
    if (!_progressView) {
        _progressView = [[MBProgressHUD alloc]initWithView:self];
        _progressView.mode = MBProgressHUDModeAnnularDeterminate;
    }
    return _progressView;
}

@end
