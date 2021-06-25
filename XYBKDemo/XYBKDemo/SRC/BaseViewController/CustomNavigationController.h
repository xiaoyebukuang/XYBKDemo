//
//  CustomNavigationController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/18.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController

+ (void)changeNavStateWithNavVC:(UINavigationController *)navigationController viewController:(UIViewController *)viewController;

@end
