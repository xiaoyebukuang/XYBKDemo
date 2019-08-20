//
//  XYTextField.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/16.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYTextField.h"

@interface XYTextField()<UITextFieldDelegate>
/** 类型 */
@property (nonatomic, assign) XYTextFieldType fieldType;

@end

@implementation XYTextField

- (instancetype)initWithType:(XYTextFieldType)filedType {
    return [self initWithType:filedType placeHolder:nil];
}

- (instancetype)initWithType:(XYTextFieldType)filedType placeHolder:(NSString *)placeHolder {
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
    self.placeholderColor = [UIColor grayColor];
    self.titleFont = [UIFont systemFontOfSize:15];
    self.maxCount = NSIntegerMax;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.textColor = [UIColor blackColor];
    self.delegate = self;
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
    // 键盘输入模式
    NSString *lang = [textField.textInputMode primaryLanguage];
    if([lang isEqualToString:@"zh-Hans"]) {
        //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if(!position) {
            if (self.fieldType == XYTextFieldChineseWord) {
                NSString *textStr = @"";
                for(int i =0; i < [textField.text length]; i++) {
                    NSString *temp = [textField.text substringWithRange:NSMakeRange(i, 1)];
                    if ([XYJudge validateChineseNumber:temp]) {
                        textStr = [textStr stringByAppendingString:temp];
                    }
                }
                textField.text = textStr;
            }
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
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
    if ([self.tool_delegate respondsToSelector:@selector(textChange:textView:)]) {
        [self.tool_delegate textChange:textField.text textView:self];
    }
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    switch (self.fieldType) {
        case XYTextFieldNumber:
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
        case XYTextFieldCharacter:
        {
            //只输入字母
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
        case XYTextFieldNumberCharacter:
        {
            //输入字母+数字
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
        case XYTextFieldChineseWord:
        {
            //中文+英文+数字
            NSString *temp =nil;
            for(int i =0; i < [string length]; i ++) {
                temp = [string substringWithRange:NSMakeRange(i,1)];
                if (!([XYJudge validateChineseNumber:temp] || [temp isEqualToString:@""])) {//当输入符合规则和退格键时允许改变输入框
                    return NO;
                }
            }
        }
            break;
        case UITextFieldToolNonChinese:
        {
            //输入字母+数据+特殊字符
            NSUInteger length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            for (int loopIndex = 0; loopIndex < length; loopIndex ++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 33) return NO;
                if (character > 126) return NO;
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
- (void)setFieldType:(XYTextFieldType)fieldType {
    _fieldType = fieldType;
    switch (_fieldType) {
        case XYTextFieldNormal:
        case XYTextFieldChineseWord:
        {
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
        case XYTextFieldNumber:
        {
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case XYTextFieldCharacter:
        case XYTextFieldNumberCharacter:
        case UITextFieldToolNonChinese:
        {
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.font = titleFont;
}

@end
