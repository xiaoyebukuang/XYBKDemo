//
//  UIScrollView+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Helper)
//TODO:刷新
/**
 添加上拉刷新
 @param headerBlock 上拉刷新
 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock;

/** 添加上拉刷新 */

/**
 添加上拉刷新

 @param hiddenStateBar 是否需要隐藏状态栏的高度
 @param headerBlock 上拉刷新
 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar
                     headerBlock:(void (^)(void))headerBlock;
/**
 添加下拉加载
 @param footerBlock 下拉加载
 */
- (void)addRefreshFooterBlock:(void (^)(void))footerBlock;

/**
 添加上拉刷新，下拉加载
 @param headerBlock 上拉刷新
 @param footerBlock 下拉加载
 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock
                  footerBlock:(void (^)(void))footerBlock;


/**
 添加上拉刷新，下拉加载
 @param hiddenStateBar 是否隐藏状态栏高度
 @param headerBlock 上拉刷新
 @param footerBlock 下拉加载
 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar
                     headerBlock:(void (^)(void))headerBlock
                     footerBlock:(void (^)(void))footerBlock;

/**
 添加上拉刷新，下拉加载
 @param hiddenStateBar 是否需要隐藏状态栏的高度
 @param insetTop 偏移量
 @param headerBlock 上拉刷新
 @param footerBlock 下拉加载
 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar
                        insetTop:(CGFloat)insetTop
                     headerBlock:(void (^)(void))headerBlock
                     footerBlock:(void (^)(void))footerBlock;

//TODO:状态
/** 开始刷新 */
- (void)beginRefresh;

/** 结束刷新和加载 */
- (void)endRefresh;

/** 结束加载 */
- (void)endFooterRefresh;
- (void)endFooterRefreshCompletionBlock:(void (^)(void))completionBlock;

/** 结束刷新 */
- (void)endHeaderRefresh;
- (void)endHeaderRefreshCompletionBlock:(void (^)(void))completionBlock;

/** 已无数据可加载 */
- (void)endRefreshNoMoreData;
/** 获取刷新状态 */
- (BOOL)footerIsRefreshing;
- (BOOL)headerIsRefreshing;
- (BOOL)isRefreshing;
/** 隐藏显示刷新 */
- (void)setHeaderRefreshHidden:(BOOL)hidden;
- (void)setFooterRefreshHidden:(BOOL)hidden;


@end
