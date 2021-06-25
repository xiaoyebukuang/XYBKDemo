//
//  BaseViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/18.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/** 默认为NO */
@property (nonatomic, assign) BOOL isFirstVC;
/** 左侧按钮 */
@property (nonatomic, strong) UIButton *base_leftBtn;
/** 右侧按钮 */
@property (nonatomic, strong) UIButton *base_rightBtn;
/** 设置导航页面按钮 */
/** 左右按钮 */
- (void)setLeftNavigationBarWithImageStr:(NSString *)imageStr;
/** 右侧按钮 */
- (void)setRightNavigationBarWithImageStr:(NSString *)imageStr;
- (void)setRightNavigationBarWithStr:(NSString *)str;
/** event */
- (void)rightNavigationBarEvent:(UIButton *)sender;
- (void)leftNavigationBarEvent:(UIButton *)sender;

/** 当push到其他页面时是否移除 */
@property (nonatomic, assign) BOOL removeWhenPush;

@end
