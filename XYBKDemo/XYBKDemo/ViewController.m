//
//  ViewController.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    dispatch_source_t _timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    UITextFieldTool *textField01 = [[UITextFieldTool alloc]initWithType:UITextFieldToolNumber placeHolder:@"请输入textField01"];
    textField01.frame = CGRectMake(40, 120, 200, 40);
    [self.view addSubview:textField01];
    
    UITextFieldTool *textField02 = [[UITextFieldTool alloc]initWithType:UITextFieldToolCharacter placeHolder:@"请输入textField02"];
    textField02.frame = CGRectMake(40, 180, 200, 40);
    [self.view addSubview:textField02];

    UITextFieldTool *textField03 = [[UITextFieldTool alloc]initWithType:UITextFieldToolNumberCharacter placeHolder:@"请输入textField03"];
    textField03.frame = CGRectMake(40, 240, 200, 40);
    [self.view addSubview:textField03];

    UITextFieldTool *textField04 = [[UITextFieldTool alloc]initWithType:UITextFieldToolWord placeHolder:@"请输入textField04"];
    textField04.frame = CGRectMake(40, 300, 200, 40);
    [self.view addSubview:textField04];
    
}
- (void)btnEvent:(UIButton *)sender {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    view.backgroundColor = [UIColor redColor];
//    [UIAlertViewTool showView:view titlesArr:@[@"我知道了"] alertBlock:^(NSString *mes, NSInteger index) {
//
//    }];
    
    [UIAlertViewTool showFieldTitle:@"我是标题" placeHolder:@"请输入标题" titlesArr:@[@"取消",@"确定"] alertBlock:^(NSString *mes, NSInteger index) {
        NSLog(@"%@",mes);
    }];
    
//    [UIAlertViewTool showTitle:@"很哈" message:@"毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。" alertBlock:^(NSString *mes, NSInteger index) {
//        
//    }];
    
    [UIAlertViewTool showScrollTitle:@"温馨提示" message:@"毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。\n毒鸡汤，就是表面看上去像是心灵鸡汤文，其实暗藏着营销和诈骗信息的文字内容。随着社交网络的兴起，过去散发过无数正能量的“鸡汤”，在社交网络乱象中变了味儿，各类“箴言妙语”目不暇接，多种广告信息难辨真假。更令人意想不到的是，这些“鸡汤文”在诱发网友转发的背后，还暗藏着一条收益不菲产业的链条。这些泛滥网络的文章大多由发布者拼凑而成，内容良莠不齐，真假难辨。" titlesArr:@[@"确定"] alertBlock:^(NSString *mes, NSInteger index) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
