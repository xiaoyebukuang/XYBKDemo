//
//  XYPhotoPickerViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerViewController.h"

#import "XYPhotoPickerGroupViewController.h"

@interface XYPhotoPickerViewController ()

@property (nonatomic , weak) XYPhotoPickerGroupViewController *groupVc;

@end

@implementation XYPhotoPickerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationController];
}
/** 设置控制器 */
- (void)createNavigationController{
    XYPhotoPickerGroupViewController* groupVc = [[XYPhotoPickerGroupViewController alloc]init];
    /** 可以自己定位导航控制器 */
    UINavigationController* nvc = [[UINavigationController alloc]initWithRootViewController:groupVc];
    nvc.navigationBar.titleTextAttributes = @{NSFontAttributeName: SYSTEM_FONT_18,NSForegroundColorAttributeName: [UIColor color_FFFFFF]};
    nvc.navigationBar.barTintColor = [UIColor color_232323];
    nvc.navigationBar.translucent = NO;
    groupVc.maxCount = self.maxCount;
    groupVc.status = self.status;
    nvc.view.frame = self.view.frame;
    self.groupVc = groupVc;
    [self addChildViewController:nvc];
    [self.view addSubview:nvc.view];
    [nvc didMoveToParentViewController:self];
}
#pragma mark -- set
- (void)setStatus:(PickerViewShowStatus)status{
    _status = status;
    self.groupVc.status = status;
}

- (void)setMaxCount:(NSInteger)maxCount{
    if (maxCount <= 0) return;
    _maxCount = maxCount;
    self.groupVc.maxCount = maxCount;
}
@end
