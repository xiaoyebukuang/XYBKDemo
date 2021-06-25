//
//  XYBannerViewTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/12.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYBannerViewTool.h"
/** 动画时间 */
const static CGFloat kXYBannerViewToolDefaultDuration           = 5.0f;

@interface XYBannerViewTool()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) XYPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *imagesArray;
/** 定时器 */
@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isRunning;

/** 底部的距离 */
@property (nonatomic, assign) CGFloat bottom_height;
@end

@implementation XYBannerViewTool
- (instancetype)initWithBottom:(CGFloat)bottom_height {
    self = [super init];
    if (self) {
        self.bottom_height = bottom_height;
        [self setupUI];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.bottom_height = 10;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.duration = kXYBannerViewToolDefaultDuration;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.bottom.equalTo(self).offset(-self.bottom_height);
        make.height.mas_equalTo(10);
    }];
}
/** 刷新视图 */
- (void)reloadViewWithArr:(NSArray *)imagesArr isRunning:(BOOL)isRunning {
    [self stopTimer];
    self.isRunning = isRunning;
    self.imagesArray = [NSMutableArray arrayWithArray:imagesArr];
    if (imagesArr.count == 1 || imagesArr.count == 0) {
        self.isRunning = NO;
    } else {
        //在数组的尾部添加原数组第一个元素
        [self.imagesArray addObject:[imagesArr firstObject]];
        //在数组的首部添加原数组最后一个元素
        [self.imagesArray insertObject:[imagesArr lastObject] atIndex:0];
    }
    [self setImageView];
    if (self.isRunning) {
        [self startTimer];
    }
    if (self.imagesArray.count == 1|| self.imagesArray.count == 0) {
        self.pageControl.hidden = YES;
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = self.imagesArray.count;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    if (self.imagesArray.count >= 2) {
        self.pageControl.hidden = NO;
        self.pageControl.numberOfPages = self.imagesArray.count - 2;
        self.pageControl.currentPage = 0;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    }
}
- (void)setImageView {
    [self layoutIfNeeded];
    for (UIView *temp in self.scrollView.subviews) {
        [temp removeFromSuperview];
    }
    for (int i = 0; i < self.imagesArray.count; i++) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
        imageView.userInteractionEnabled = YES;
        if (self.masksToBounds) {
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 10;
        }
        imageView.contentMode = self.contentMode;
        imageView.clipsToBounds = YES;
        id temp = self.imagesArray[i];
        if ([temp isKindOfClass:[NSString class]]) {
            imageView.image = [UIImage imageNamed:(NSString *)temp];
        } else if ([temp isKindOfClass:[NSURL class]]) {
            if (self.showImage) {
                [imageView sd_setImageWithURL:(NSURL *)temp placeholderImage:[UIImage imageNamed:self.placeholderStr] options:SDWebImageRetryFailed];
            } else {
                [imageView yy_setImageWithURL:(NSURL *)temp placeholder:[UIImage imageNamed:self.placeholderStr] options:YYWebImageOptionIgnoreFailedURL completion:nil];
            }
        } else if ([temp isKindOfClass:[UIImage class]]) {
            imageView.image = (UIImage *)temp;
        }
        [self.scrollView addSubview:imageView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEvent:)];
        [imageView addGestureRecognizer:tapGesture];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*MAIN_SCREEN_WIDTH + self.levelSpace);
            make.top.height.equalTo(self.scrollView);
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH - 2*self.levelSpace);
        }];
    }
    self.scrollView.contentSize = CGSizeMake(self.imagesArray.count*MAIN_SCREEN_WIDTH, self.height);
}
- (void)scrollToPage:(NSInteger)page {
    self.pageControl.currentPage = page;
    if (self.imagesArray.count == 1) {
        [self.scrollView setContentOffset:CGPointMake(page*self.scrollView.width, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake((page+1)*self.scrollView.width, 0) animated:NO];
    }
}
#pragma mark -- evetn
//手势点击
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap {
    if (self.imagesArray.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannerViewToolEvent:imageView:)]) {
            [self.delegate bannerViewToolEvent:self.pageControl.currentPage imageView:(UIImageView *)tap.view];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannerViewToolEvent:imageView:bannerViewTool:)]) {
            [self.delegate bannerViewToolEvent:self.pageControl.currentPage imageView:(UIImageView *)tap.view bannerViewTool:self];
        }
    }
}
#pragma mark - Timer时间方法
-(void)startTimer {
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:self.duration target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
- (void)updateTimer {
    CGFloat scroll_width = CGRectGetWidth(self.scrollView.frame);
    if (self.scrollView.contentOffset.x == scroll_width*(self.imagesArray.count - 1)) {
        [self.scrollView setContentOffset:CGPointMake(scroll_width, 0) animated:NO];
    }
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x  + scroll_width, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = newOffset;
    } completion:^(BOOL finished) {
        NSInteger number = newOffset.x/scroll_width;
        if (number == self.imagesArray.count - 1) {
            self.scrollView.contentOffset = CGPointMake(scroll_width, 0);
            self.pageControl.currentPage = 0;
        } else {
            self.pageControl.currentPage += 1;
        }
    }];
}
- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
#pragma mark UIScrollViewDelegate
/** 开始滚动时 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) {
        return;
    }
    if (self.imagesArray.count <= 1) {
        return;
    }
    CGFloat scroll_width = CGRectGetWidth(scrollView.frame);
    if (scrollView.contentOffset.x < scroll_width) {
        [self.scrollView setContentOffset:CGPointMake(scroll_width*(self.imagesArray.count - 1), 0) animated:NO];
    }
    if (scrollView.contentOffset.x > scroll_width*(self.imagesArray.count - 1)) {
        [self.scrollView setContentOffset:CGPointMake(scroll_width, 0) animated:NO];
    }
}
/** 停止滚动时 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.imagesArray.count <= 1) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (currentPage > self.imagesArray.count - 2) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = currentPage - 1;
    }
    if (self.isRunning) {
        [self startTimer];
    }
}
/** 开始拖动时 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
#pragma mark -- setup
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (XYPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[XYPageControl alloc]init];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}
@end
