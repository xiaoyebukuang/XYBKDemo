//
//  ViewController.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ViewController.h"
#import "XYPhotoPickerViewController.h"
#import "UITextFieldTool.h"


@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    XYBannerViewTool *bannerViewTool = [[XYBannerViewTool alloc]init];
//    [self.view addSubview: bannerViewTool];
//    [bannerViewTool mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.top.equalTo(self.view);
//        make.height.mas_equalTo(300);
//    }];
    
//    [bannerViewTool reloadViewWithArr:@[@"broswerPic0.jpg",@"broswerPic1.jpg",@"broswerPic2.jpg",@"broswerPic3.jpg",@"broswerPic4.jpg",@"broswerPic5.jpg"] isRunning:YES];
    
//    [bannerViewTool reloadViewWithArr:@[@"broswerPic0.jpg"] isRunning:YES];
    
    
//
//
//    UITextFieldTool *textField01 = [[UITextFieldTool alloc]initWithType:UITextFieldToolNormal placeHolder:@"textField01"];
//    textField01.maxCount = 10;
//    [self.view addSubview:textField01];
//
//    [textField01 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.top.equalTo(self.view).offset(64);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(40);
//    }];
//
//    UITextFieldTool *textField02 = [[UITextFieldTool alloc]initWithType:UITextFieldToolNumber placeHolder:@"textField02"];
//    textField02.maxCount = 9;
//    [self.view addSubview:textField02];
//
//    [textField02 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.left.equalTo(textField01);
//        make.top.equalTo(textField01.mas_bottom).offset(10);
//    }];
//
//
//    UITextFieldTool *textField03 = [[UITextFieldTool alloc]initWithType:UITextFieldToolCharacter placeHolder:@"textField03"];
//    textField03.maxCount = 9;
//    [self.view addSubview:textField03];
//
//    [textField03 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.left.equalTo(textField01);
//        make.top.equalTo(textField02.mas_bottom).offset(10);
//    }];
//
//
//    UITextFieldTool *textField04 = [[UITextFieldTool alloc]initWithType:UITextFieldToolNumberCharacter placeHolder:@"textField04"];
//    textField04.maxCount = 9;
//    [self.view addSubview:textField04];
//
//    [textField04 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.left.equalTo(textField01);
//        make.top.equalTo(textField03.mas_bottom).offset(10);
//    }];
//
//
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:btn];
//
//
//
//    [self.view addSubview:self.tableView];
//    [MJRefreshTool addRefreshToolWithScrollView:self.tableView headerBlock:^{
//        [MJRefreshTool  endRefresh:self.tableView];
//    }];
}
- (void)btnEvent:(UIButton *)sender {
    XYPhotoPickerViewController *vc = [[XYPhotoPickerViewController alloc]init];
    vc.maxCount = 9;
    vc.status = PickerViewShowStatusCameraRoll;
    [self presentViewController:vc animated:YES completion:nil];
    
    //照片
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 6; i++) {
//        XYPhotoBrowserModel *photo = [[XYPhotoBrowserModel alloc] initWithObj:[UIImage imageNamed:[NSString stringWithFormat:@"broswerPic%d.jpg",i]]];
//        [array addObject:photo];
//    }
    
//
//
//
//    XYPhotoBrowserModel *photo = [[XYPhotoBrowserModel alloc] init];
//    photo.photoURL = [NSURL URLWithString:@"http://img.ivsky.com/img/bizhi/slides/201511/11/december.jpg"];
//    [array addObject:photo];
//
//    XYPhotoBrowserModel *photo1 = [[XYPhotoBrowserModel alloc] init];
//    photo1.photoURL = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/267f9e2f0708283890f56e02bb99a9014c08f128.jpg"];
//    [array addObject:photo1];
//
//    XYPhotoBrowserModel *photo2 = [[XYPhotoBrowserModel alloc] init];
//    photo2.photoURL = [NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/b219ebc4b74543a9fa0c4bc11c178a82b90114a3.jpg"];
//    [array addObject:photo2];
//
//    XYPhotoBrowserModel *photo3 = [[XYPhotoBrowserModel alloc] init];
//    photo3.photoURL = [NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/024f78f0f736afc33b1dbe65b119ebc4b7451298.jpg"];
//    [array addObject:photo3];
//
//    XYPhotoBrowserModel *photo4 = [[XYPhotoBrowserModel alloc] init];
//    photo4.photoURL = [NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/77094b36acaf2edd481ef6e78f1001e9380193d5.jpg"];
//    [array addObject:photo4];
    
//    XYPhotoBrowserViewController *vc = [[XYPhotoBrowserViewController alloc]init];
//    vc.photosArr = array;
//    vc.currentPage = 2;
//    [self presentViewController:vc animated:YES completion:nil];

    
    
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
//    view.backgroundColor = [UIColor redColor];
//    [UIAlertViewTool showView:view titlesArr:@[@"我知道了"] alertBlock:^(NSString *mes, NSInteger index) {
//
//    }];
    
//    [UIAlertViewTool showFieldTitle:@"我是标题" placeHolder:@"请输入标题" titlesArr:@[@"取消",@"确定"] alertBlock:^(NSString *mes, NSInteger index) {
//        NSLog(@"%@",mes);
//    }];
    
//    [UIAlertViewTool showTitle:@"很哈" message:@"毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。" alertBlock:^(NSString *mes, NSInteger index) {
//        
//    }];
    
//    [UIAlertViewTool showScrollTitle:@"温馨提示" message:@"毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。\n毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。" titlesArr:@[@"确定"] alertBlock:^(NSString *mes, NSInteger index) {
//
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    }
    return _tableView;
}


@end
