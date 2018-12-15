//
//  XYTextField.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XYTextFieldType) {
    XYTextFieldNormal,          //常规输入
    XYTextFieldNumber,          //限制数字
    XYTextFieldCharacter,       //限制字母
    XYTextFieldNumberCharacter, //限制数字+字母
    XYTextFieldChineseWord      //中文+英文+数字
};

@class XYTextField;
@protocol XYTextFieldDelegate <NSObject>

- (void)textChange:(NSString *)text textView:(XYTextField *)textView;

@end


@interface XYTextField : UITextField

/** 最大限制个数 */
@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, weak) id<XYTextFieldDelegate> tool_delegate;

/**
 创建UITextField（类型）
 
 @param filedType 类型
 @return 返回UITextField
 */
- (instancetype)initWithType:(XYTextFieldType)filedType;

/**
 创建UITextField（类型+提示）
 
 @param filedType 类型
 @param placeHolder 默认提示
 @return 返回UITextField
 */
- (instancetype)initWithType:(XYTextFieldType)filedType placeHolder:(NSString *)placeHolder;

@end
