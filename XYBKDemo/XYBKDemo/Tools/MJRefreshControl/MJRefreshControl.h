//
//  MJRefreshControl.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJRefreshControl : NSObject
/**
 添加上拉刷新，下拉加载
 
 @param scroll 视图
 @param headerBlock 上拉刷新
 @param footerBlock 下拉加载
 */
+ (void)addRefreshControlWithScrollView:(UIScrollView *)scroll headerBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock;

/**
 添加上拉刷新
 
 @param scroll 视图
 @param headerBlock 上拉刷新
 */
+ (void)addRefreshControlWithScrollView:(UIScrollView *)scroll headerBlock:(void (^)(void))headerBlock;


/**
 开始刷新
 
 @param scroll 视图
 */
+ (void)beginRefresh:(UIScrollView *)scroll;


/**
 结束刷新和加载
 
 @param scroll 视图
 */
+ (void)endRefresh:(UIScrollView *)scroll;


/**
 已无数据可加载
 
 @param scroll 视图
 */
+ (void)endRefreshNoData:(UIScrollView *)scroll;
@end
