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
    UITextFieldToolChineseWord,     //中文+英文+数字
    UITextFieldToolNonChinese,      //限制字母+数字+特殊字符
};

@class UITextFieldTool;

@protocol UITextFieldToolDelegate <NSObject>

@optional

- (void)textChange:(NSString *)text textViewTool:(UITextFieldTool *)textFieldTool;
/** 开始编辑 */
- (void)textFieldToolDidBeginEditing:(UITextFieldTool *)textFieldTool;
/** 结束编辑 */
- (void)textFieldToolDidEndEditing:(UITextFieldTool *)textFieldTool;


@end

@interface UITextFieldTool : UITextField

@property (nonatomic, weak) id<UITextFieldToolDelegate> tool_delegate;
/** 提示语句颜色 默认999999 */
@property (nonatomic, strong) UIColor *placeholderColor;
/**默认提示语句 */
@property (nonatomic, copy) NSString *placeholderStr;
/** 字体大小 默认15 */
@property (nonatomic, strong) UIFont *titleFont;
/** 最大限制个数 */
@property (nonatomic, assign) NSInteger maxCount;
/** 小写转大写 */
@property (nonatomic, assign) BOOL transUppercase;
/** 类型 */
@property (nonatomic, assign) UITextFieldToolType fieldType;
/** 左侧view大小 */
@property (nonatomic, assign) CGRect leftViewBounds;

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
