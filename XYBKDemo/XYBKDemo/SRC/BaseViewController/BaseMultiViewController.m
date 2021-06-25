//
//  BaseMultiViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/23.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"
#import "CustomNavigationController.h"
@interface BaseMultiViewController ()

@end

@implementation BaseMultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavigationBarWithImageStr:@"black_back"];
    self.base_leftBtn.hidden = self.isFirstVC;
}
- (void)leftNavigationBarEvent:(UIButton *)sender {
    [super leftNavigationBarEvent:sender];
    [XYNetworking cancelAllTask];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
