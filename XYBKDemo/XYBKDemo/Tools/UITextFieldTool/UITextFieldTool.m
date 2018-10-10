//
//  UITextFieldTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UITextFieldTool.h"

@interface UITextFieldTool()<UITextFieldDelegate>
/** 类型 */
@property (nonatomic, assign) UITextFieldToolType fieldType;
/** 最大限制个数 */
@property (nonatomic, assign) NSInteger maxCount;
@end

@implementation UITextFieldTool

- (instancetype)initWithType:(UITextFieldToolType)filedType {
    return [self initWithType:_fieldType placeHolder:nil];
}

- (instancetype)initWithType:(UITextFieldToolType)filedType placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        if (placeHolder) {
            self.placeholder = placeHolder;
        }
        self.fieldType = filedType;
        [self setData];
    }
    return self;
}
- (void)setData {
    self.delegate = self;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.font = [UIFont systemFontOfSize:15];
    self.textColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:self];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//监听文本改变
-(void)textViewEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    //限制输入字符数
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if(toBeString.length > self.maxCount) {
                textField.text = [toBeString substringToIndex:self.maxCount];
            }
        } else {
            //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if(toBeString.length > self.maxCount) {
            textField.text= [toBeString substringToIndex:self.maxCount];
        }
    }
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (self.fieldType) {
        case UITextFieldToolNumber:
        {
            //只输入数字
            NSUInteger length = string.length;
            for (int loopIndex = 0; loopIndex < length; loopIndex ++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 48) return NO;
                if (character > 57) return NO;
            }
            NSUInteger proposeLength = textField.text.length - range.length + string.length;
            if (proposeLength > self.maxCount) {
                return NO;
            }
        }
            break;
        case UITextFieldToolCharacter:
        {
            //只输入字符
            NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            for (int loopIndex = 0; loopIndex < length; loopIndex ++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 65) return NO;
                if (character > 90 && character < 97) return NO;
                if (character > 122) return NO;
            }
            NSUInteger proposeLength = textField.text.length - range.length + string.length;
            if (proposeLength > self.maxCount) {
                return NO;
            }
        }
            break;
        case UITextFieldToolNumberCharacter:
        {
            //输入字符+数字
            NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            for (int loopIndex = 0; loopIndex < length; loopIndex ++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 48) return NO;
                if (character > 57 && character < 65) return NO;
                if (character > 90 && character < 97) return NO;
                if (character > 122) return NO;
            }
            NSUInteger proposeLength = textField.text.length - range.length + string.length;
            if (proposeLength > self.maxCount) {
                return NO;
            }
        }
            break;
        default:
            break;
    }
    return YES;
}


#pragma mark -- setup
- (void)setFieldType:(UITextFieldToolType)fieldType {
    _fieldType = fieldType;
    switch (self.fieldType) {
        case UITextFieldToolNormal:
        {
            self.maxCount = NSIntegerMax;
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
        case UITextFieldToolNumber:
        {
            self.maxCount = 11;
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case UITextFieldToolCharacter:
        {
            self.maxCount = 10;
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
        case UITextFieldToolNumberCharacter:
        {
            self.maxCount = 9;
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
        case UITextFieldToolWord:
        {
            self.maxCount = 6;
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
        default:
            break;
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

@end
