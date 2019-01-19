//
//  XYPhotoNavigationController.m
//  XYBKDemo
//
//  Created by 陈晓 on 2019/1/19.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "XYPhotoNavigationController.h"

@interface XYPhotoNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation XYPhotoNavigationController

- (void)viewDidLoad{
    self.delegate = self;
    self.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: SYSTEM_FONT_24,NSForegroundColorAttributeName: [UIColor color_FFFFFF]};
    self.navigationBar.barTintColor = [UIColor color_232323];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self setNavigationBarHidden:NO animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count <= 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


@end
