//
//  UIScrollView+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIScrollView+Helper.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (Helper)
#pragma mark -- 添加刷新控件
/** 添加上拉刷新 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock {
    [self addRefreshHeaderBlock:headerBlock footerBlock:nil];
}
/** 添加上拉刷新 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar headerBlock:(void (^)(void))headerBlock {
    [self addRefreshHiddenStateBar:hiddenStateBar insetTop:0 headerBlock:headerBlock footerBlock:nil];
}
/** 添加下拉加载 */
- (void)addRefreshFooterBlock:(void (^)(void))footerBlock {
    [self addRefreshHeaderBlock:nil footerBlock:footerBlock];
}
/** 添加上拉刷新，下拉加载 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    [self addRefreshHiddenStateBar:YES headerBlock:headerBlock footerBlock:footerBlock];
}
/** 添加上拉刷新，下拉加载 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar headerBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    [self addRefreshHiddenStateBar:hiddenStateBar insetTop:0 headerBlock:headerBlock footerBlock:footerBlock];
}
/** 添加上拉刷新，下拉加载 */
- (void)addRefreshHiddenStateBar:(BOOL) hiddenStateBar insetTop:(CGFloat)insetTop headerBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    if (headerBlock) {
        //头视图
        WeakSelf;
        MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (!weakSelf.footerIsRefreshing) {
                headerBlock();
            } else {
                [weakSelf endHeaderRefresh];
            }
        }];
        self.mj_header = mj_header;
    }
    if (footerBlock) {
        //尾视图
        WeakSelf;
        MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!weakSelf.headerIsRefreshing) {
                footerBlock();
            } else {
                [weakSelf endFooterRefresh];
            }
        }];
        self.mj_footer = mj_footer;
    }
}
#pragma mark -- 状态
/** 开始刷新 */
- (void)beginRefresh {
    [self.mj_header beginRefreshing];
}

/** 结束刷新和加载 */
- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

/** 结束加载 */
- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}
- (void)endFooterRefreshCompletionBlock:(void (^)(void))completionBlock {
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshingWithCompletionBlock:completionBlock];
    } else {
        completionBlock();
    }
}

/** 结束刷新 */
- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
}
- (void)endHeaderRefreshCompletionBlock:(void (^)(void))completionBlock {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshingWithCompletionBlock:completionBlock];
    } else {
        completionBlock();
    }
}
/** 已无数据可加载 */
- (void)endRefreshNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}
/** 是否在刷新 */
- (BOOL)footerIsRefreshing {
    return [self.mj_footer isRefreshing];
}
- (BOOL)headerIsRefreshing {
    return [self.mj_header isRefreshing];
}
- (BOOL)isRefreshing {
    BOOL isRe = [self.mj_header isRefreshing] || [self.mj_footer isRefreshing];
    return isRe;
}
/** 隐藏显示刷新 */
- (void)setHeaderRefreshHidden:(BOOL)hidden {
    self.mj_header.hidden = hidden;
}
- (void)setFooterRefreshHidden:(BOOL)hidden {
    self.mj_footer.hidden = hidden;
}
@end
