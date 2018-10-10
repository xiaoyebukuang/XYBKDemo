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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
