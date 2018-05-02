//
//  MJRefreshControl.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MJRefreshControl.h"
#import <MJRefresh.h>

@implementation MJRefreshControl
+ (void)addRefreshControlWithScrollView:(UIScrollView *)scroll headerBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    
    __weak UIScrollView *temp = scroll;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [temp.mj_footer resetNoMoreData];
        headerBlock();
    }];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    scroll.mj_header = mj_header;
    
    MJRefreshBackStateFooter *mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        footerBlock();
    }];
    [mj_footer setTitle:@"暂未更多数据" forState:MJRefreshStateNoMoreData];
    scroll.mj_footer = mj_footer;
}

+ (void)addRefreshControlWithScrollView:(UIScrollView *)scroll headerBlock:(void (^)(void))headerBlock {
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        headerBlock();
    }];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    scroll.mj_header = mj_header;
}

+ (void)beginRefresh:(UIScrollView *)scroll {
    [scroll.mj_header beginRefreshing];
}

+ (void)endRefresh:(UIScrollView *)scroll {
    if ([scroll.mj_header isRefreshing]) {
        [scroll.mj_header endRefreshing];
    }
    if ([scroll.mj_footer isRefreshing]) {
        [scroll.mj_footer endRefreshing];
    }
}

+ (void)endRefreshNoData:(UIScrollView *)scroll {
    [scroll.mj_footer endRefreshingWithNoMoreData];
}

@end
