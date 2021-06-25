//
//  BaseViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/18.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomNavigationController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc = %@",[self class]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_main];
}
#pragma mark -- 导航按钮
- (void)setLeftNavigationBarWithImageStr:(NSString *)imageStr {
    if (!imageStr) {
        return;
    }
    self.base_leftBtn = [UIButton buttonWithImage:imageStr];
    self.base_leftBtn.frame = CGRectMake(0, 0, 44, 44);
    self.base_leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.base_leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.base_leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}
/** imageStr */
- (void)setRightNavigationBarWithImageStr:(NSString *)imageStr {
    if (!imageStr) {
        return;
    }
    self.base_rightBtn = [UIButton buttonWithImage:imageStr];
    self.base_rightBtn.frame = CGRectMake(0, 0, 44, 44);
    self.base_rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.base_rightBtn addTarget:self action:@selector(rightNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.base_rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
/** title */
- (void)setRightNavigationBarWithStr:(NSString *)str {
    CGFloat width = [str getStrWidthWithFont:SYSTEM_FONT_14];
    if (width < 44) {
        width = 44;
    }
    self.base_rightBtn = [UIButton buttonWithTitle:str titleColor:[UIColor color_222222] font:SYSTEM_FONT_14];
    self.base_rightBtn.frame = CGRectMake(0, 0, width, 44);
    self.base_rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.base_rightBtn addTarget:self action:@selector(rightNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.base_rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[CustomNavigationController class]]||[viewControllerToPresent isKindOfClass:[BaseViewController class]]) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
#pragma mark -- event
- (void)rightNavigationBarEvent:(UIButton *)sender {
    
}
- (void)leftNavigationBarEvent:(UIButton *)sender {
    
}
#pragma mark - 屏幕旋转
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
