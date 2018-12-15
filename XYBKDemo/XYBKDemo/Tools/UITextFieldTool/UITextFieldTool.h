//
//  UITextFieldTool.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITextFieldToolType) {
    UITextFieldToolNormal,          //常规输入
    UITextFieldToolNumber,          //限制数字
    UITextFieldToolCharacter,       //限制字母
    UITextFieldToolNumberCharacter, //限制数字+字母
    UITextFieldToolChineseWord      //中文+英文+数字
};

@class UITextFieldTool;
@protocol UITextFieldToolDelegate <NSObject>

- (void)textChange:(NSString *)text textViewTool:(UITextFieldTool *)textViewTool;

@end

@interface UITextFieldTool : UITextField

/** 最大限制个数 */
@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, weak) id<UITextFieldToolDelegate> tool_delegate;

/**
 创建UITextField（类型）

 @param filedType 类型
 @return 返回UITextField
 */
- (instancetype)initWithType:(UITextFieldToolType)filedType;

/**
 创建UITextField（类型+提示）
 
 @param filedType 类型
 @param placeHolder 默认提示
 @return 返回UITextField
 */
- (instancetype)initWithType:(UITextFieldToolType)filedType placeHolder:(NSString *)placeHolder;




@end
