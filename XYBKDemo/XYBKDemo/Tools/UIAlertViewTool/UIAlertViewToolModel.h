//
//  UIAlertViewToolModel.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
//弹框类型
typedef NS_ENUM(NSInteger, UIAlertViewType) {
    UIAlertViewTypeNormal       //普通类型（取消确定）;
};
//确定取消回调
typedef void(^AlertBlock)(NSInteger index);

@interface UIAlertViewToolModel : NSObject

//按钮标题数组
@property (nonatomic, strong) NSArray *btnTitles;
//标题
@property (nonatomic, copy) NSString *title;
//信息
@property (nonatomic, copy) NSString *message;
//弹框类型
@property (nonatomic, assign) UIAlertViewType alertViewType;
//回调
@property (nonatomic, copy) AlertBlock alertBlock;

@end
