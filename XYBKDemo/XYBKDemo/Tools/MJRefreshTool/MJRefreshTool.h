//
//  MJRefreshTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 上拉加载，下拉刷新，在block回调中注意使用弱引用，防止循环引用。
 */
@interface MJRefreshTool : NSObject
/**
 添加上拉刷新，下拉加载

 @param scroll 视图
 @param headerBlock 上拉刷新
 @param footerBlock 下拉加载
 */
+ (void)addRefreshToolWithScrollView:(UIScrollView *)scroll
                         headerBlock:(void (^)(void))headerBlock
                         footerBlock:(void (^)(void))footerBlock;

/**
 添加上拉刷新
 
 @param scroll 视图
 @param headerBlock 上拉刷新
 */
+ (void)addRefreshToolWithScrollView:(UIScrollView *)scroll
                         headerBlock:(void (^)(void))headerBlock;


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
