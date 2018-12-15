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
 添加刷新
 @param headerBlock 刷新
 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock;

/**
 添加加载
 @param footerBlock 加载
 */
- (void)addRefreshFooterBlock:(void (^)(void))footerBlock;

/**
 添加刷新&加载
 @param headerBlock 刷新
 @param footerBlock 加载
 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock
                  footerBlock:(void (^)(void))footerBlock;



//TODO:状态
/** 开始刷新 */
- (void)beginRefresh;

/** 结束刷新和加载 */
- (void)endRefresh;

/** 结束刷新 */
- (void)endHeaderRefresh;
- (void)endHeaderRefreshCompletionBlock:(void (^)(void))completionBlock;

/** 结束加载 */
- (void)endFooterRefresh;
- (void)endFooterRefreshCompletionBlock:(void (^)(void))completionBlock;

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
