//
//  XYPageControl.m
//  cwz51
//
//  Created by 陈晓 on 2018/12/22.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPageControl.h"

@interface XYPageControl()

@property (nonatomic, strong) UIView *pageView;

@end

@implementation XYPageControl

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self.pageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((self.numberOfPages - 1)*(self.normalWidth + self.space) + self.currentWidth);
        make.centerX.bottom.equalTo(self);
        make.height.mas_equalTo(self.currentHeight);
    }];
    [self setNeedsLayout];
}
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    [self setNeedsLayout];
}
- (void)setupUI {
    self.currentWidth = 12;
    self.normalWidth = 6;
    self.currentHeight = 5;
    self.space = 5;
    self.pageIndicatorTintColor = [UIColor color_E6E6E6];
    self.currentPageIndicatorTintColor = [UIColor color_FF5400];
    [self addSubview:self.pageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self.pageView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat start_left = 0;
    for (int i = 0; i < self.numberOfPages; i ++) {
        UIView *pageChildV = [[UIView alloc]init];
        pageChildV.layer.masksToBounds = YES;
        pageChildV.layer.cornerRadius = self.currentHeight/2;
        pageChildV.backgroundColor = self.currentPage == i ? self.currentPageIndicatorTintColor:self.pageIndicatorTintColor;
        [self.pageView addSubview:pageChildV];
        CGFloat page_width = (self.currentPage == i ? self.currentWidth:self.normalWidth);
        pageChildV.frame = CGRectMake(start_left, 0, page_width, self.pageView.height);
        start_left += page_width + self.space;
    }
}
#pragma mark -- setup

- (UIView *)pageView {
    if (!_pageView) {
        _pageView = [[UIView alloc]init];
    }
    return _pageView;
}


@end
