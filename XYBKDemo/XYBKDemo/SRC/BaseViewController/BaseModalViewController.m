//
//  BaseModalViewController.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/10.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseModalViewController.h"
#import "CustomNavigationController.h"
@interface BaseModalViewController ()

@end

@implementation BaseModalViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backControl];
    [self.backControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
+ (void)preparePushVCWithVC:(UIViewController *)controller childViewController:(BaseModalViewController *)childViewController completion:(void (^ __nullable)(void))completion {
    CustomNavigationController *nv = [[CustomNavigationController alloc]initWithRootViewController:childViewController];
    [controller presentViewController:nv animated:NO completion:completion];
}
- (void)pushVCWithAnimation:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    self.backControl.alpha = 0;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.backControl.alpha = 1;
        if (animations) {
            animations();
        }
    } completion:completion];
}
- (void)popVCWithAnimation:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.backControl.alpha = 0;
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (completion) {
                completion(finished);
            }
        }];
    }];
}
+ (void)preparePushVCWithVC:(UIViewController *)controller childViewController:(BaseModalViewController *)childViewController animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    [controller addChildViewController:childViewController];
    [controller.view addSubview:childViewController.view];
    childViewController.backControl.alpha = 0;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        childViewController.backControl.alpha = 1;
        if (animations) {
            animations();
        }
    } completion:completion];
}
#pragma mark -- event
- (void)backControlEvent:(UIButton *)sender {
    
}
#pragma mark -- setup
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc]init];
        [_backControl addTarget:self action:@selector(backControlEvent:) forControlEvents:UIControlEventTouchUpInside];
        _backControl.backgroundColor = [UIColor color_000000_5];
    }
    return _backControl;
}


@end
