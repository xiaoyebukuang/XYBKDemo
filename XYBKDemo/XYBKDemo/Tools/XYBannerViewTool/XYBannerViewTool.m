//
//  XYBannerViewTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/12.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYBannerViewTool.h"
/** 按钮高度 */
const static CGFloat kXYBannerViewToolDefaultDuration           = 3.0f;

@interface XYBannerViewTool()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *imagesArray;
/** 定时器 */
@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isRunning;

@end

@implementation XYBannerViewTool
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
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
        make.bottom.equalTo(self).offset(-10);
    }];
}
- (void)reloadViewWithArr:(NSArray *)imagesArr isRunning:(BOOL)isRunning {
    if (imagesArr.count == 0) {
        return;
    }
    [self stopTimer];
    self.isRunning = isRunning;
    self.imagesArray = [NSMutableArray arrayWithArray:imagesArr];
    if (imagesArr.count == 1) {
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
    [self setNeedsLayout];
}
- (void)setImageView {
    for (UIView *temp in self.scrollView.subviews) {
        [temp removeFromSuperview];
    }
    UIImageView *imageV;
    for (int i = 0; i < self.imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:self.imagesArray[i]];
        [self.scrollView addSubview:imageView];
        if (imageV) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.width.height.equalTo(self.scrollView);
                make.left.equalTo(imageV.mas_right);
            }];
        } else {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.width.height.equalTo(self.scrollView);
            }];
        }
        imageV = imageView;
    }
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageV);
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imagesArray.count == 0) {
        return;
    }
    if (self.imagesArray.count == 1) {
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
#pragma mark -- evetn
//手势点击
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap {
    if (self.imagesArray.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannerViewToolEvent:)]) {
            [self.delegate bannerViewToolEvent:self.pageControl.currentPage];
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
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEvent:)];
        [_scrollView addGestureRecognizer:tapGesture];
    }
    return _scrollView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}
@end
