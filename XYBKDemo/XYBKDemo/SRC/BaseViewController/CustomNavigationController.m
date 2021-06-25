//
//  CustomNavigationController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/18.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "CustomNavigationController.h"
#import "BaseWebviewViewController.h"
#import "BaseViewController.h"
@interface CustomNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

/** 是否隐藏状态栏 */
@property (nonatomic, assign) BOOL hiddenStatusBar;

@end

@implementation CustomNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
    self.hiddenStatusBar = NO;
    self.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: SYSTEM_FONT_B_18,NSForegroundColorAttributeName: [UIColor color_222222]};
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 当前导航栏, 只有第一个viewController push的时候设置隐藏
        if (self.viewControllers.count == 1) {
            viewController.hidesBottomBarWhenPushed = YES;
        } else {
            viewController.hidesBottomBarWhenPushed = NO;
        }
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    NSMutableArray *removeArray = [NSMutableArray array];
    BOOL removeHidesBottom = NO;
    if (self.viewControllers.count > 1) {
        for (int i = 0; i < self.viewControllers.count - 1; i ++) {
            BaseViewController *vc = self.viewControllers[i];
            if (vc.removeWhenPush) {
                if (vc.hidesBottomBarWhenPushed) {
                    removeHidesBottom = YES;
                }
                [removeArray addObject:vc];
            }
        }
    }
    NSMutableArray *viewC = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewC removeObjectsInArray:removeArray];
    if (removeHidesBottom && viewC.count >= 1) {
        UIViewController *hidesVC = viewC[1];
        hidesVC.hidesBottomBarWhenPushed = YES;
    }
    self.viewControllers = viewC;
    return [super popViewControllerAnimated:animated];
}

#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /** 需要隐藏导航的的vc */
    NSArray *hidenControllers = @[];
    Class currentClass = self.topViewController.class;
    
    if ([currentClass isSubclassOfClass:[BaseWebviewViewController class]]) {
        [self setNavigationBarHidden:YES animated:YES];
    } else {
        if ([hidenControllers containsObject:NSStringFromClass(self.topViewController.class)]) {
            [self setNavigationBarHidden:YES animated:YES];
        } else {
            NSString *modeClass = @"";          //模态视图跳转
            if ([self.topViewController.class isSubclassOfClass:NSClassFromString(modeClass)]) {
                [self setNavigationBarHidden:YES animated:YES];
            } else {
                [self setNavigationBarHidden:NO animated:YES];
                [CustomNavigationController changeNavStateWithNavVC:self viewController:self.topViewController];
            }
        }
    }
}
+ (void)changeNavStateWithNavVC:(UINavigationController *)navigationController viewController:(UIViewController *)viewController {
    /** 需要改变导航背景图片的vc */
    NSArray *bgImgControllers = @[@""];
    if ([bgImgControllers containsObject:NSStringFromClass(viewController.class)]) {
        UIImage *navBgImage = [UIImage getStretchableImageWithImageName:@"nav_car_wash_bg"];
        [navigationController.navigationBar setBackgroundImage:navBgImage forBarMetrics:UIBarMetricsDefault];
    } else {
        [navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /** 禁用手势返回的页面 */
    NSArray *noPopGesController = @[];
    if (self.viewControllers.count <= 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        if ([noPopGesController containsObject:NSStringFromClass(self.topViewController.class)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
- (BOOL)prefersStatusBarHidden{
    return self.hiddenStatusBar;
}
#pragma mark - 关于旋转的设置
//是否自动旋转
-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

//支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

//默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}
@end
