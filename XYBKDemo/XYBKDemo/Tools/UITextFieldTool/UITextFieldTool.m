//
//  UITextFieldTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/10.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UITextFieldTool.h"

@interface UITextFieldTool()<UITextFieldDelegate>

@end

@implementation UITextFieldTool

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleFont = SYSTEM_FONT_14;
        self.maxCount = NSIntegerMax;
        [self setData];
    }
    return self;
}

- (instancetype)initWithType:(UITextFieldToolType)filedType {
    return [self initWithType:filedType placeHolder:nil];
}

- (instancetype)initWithType:(UITextFieldToolType)filedType placeHolder:(NSString *)placeHolder {
    self = [super init];
    if (self) {
        if (placeHolder) {
            self.placeholderStr = placeHolder;
        }
        self.titleFont = SYSTEM_FONT_14;
        self.maxCount = NSIntegerMax;
        self.fieldType = filedType;
        [self setData];
    }
    return self;
}
- (void)setData {
    self.delegate = self;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.borderStyle = UITextBorderStyleNone;
    self.textColor = [UIColor color_222222];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:self];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, 30, 30);
}
//监听文本改变
- (void)textViewEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
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
        }
    } else {
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if(toBeString.length > self.maxCount) {
            textField.text = [toBeString substringToIndex:self.maxCount];
        }
    }
    if (self.transUppercase) {
        textField.text = [textField.text uppercaseString];
    }
    switch (self.fieldType) {
        case UITextFieldToolNumber:
        case UITextFieldToolCharacter:
        case UITextFieldToolNumberCharacter:
        case UITextFieldToolNonChinese:
            textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            break;
        default:
            break;
    }
    if ([self.tool_delegate respondsToSelector:@selector(textChange:textViewTool:)]) {
        [self.tool_delegate textChange:textField.text textViewTool:self];
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
        case UITextFieldToolNumberCharacter:
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
        case UITextFieldToolChineseWord:
        {
            //中文+英文+数字
            NSString *temp =nil;
            for(int i =0; i < [string length]; i ++) {
                temp = [string substringWithRange:NSMakeRange(i,1)];
                if (!([self isInputRuleNotBlank:temp] || [temp isEqualToString:@""])) {//当输入符合规则和退格键时允许改变输入框
                    return NO;
                }
            }
        }
            break;
        case UITextFieldToolNonChinese:
        {
            //输入字母+数据+特殊字符
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
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
//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.tool_delegate respondsToSelector:@selector(textFieldToolDidBeginEditing:)]) {
        [self.tool_delegate textFieldToolDidBeginEditing:self];
    }
}
//结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.tool_delegate respondsToSelector:@selector(textFieldToolDidEndEditing:)]) {
        [self.tool_delegate textFieldToolDidEndEditing:self];
    }
}
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
- (BOOL)isInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"[➋➌➍➎➏➐➑➒0-9a-zA-Z\u4e00-\u9fa5]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}



#pragma mark -- setup
- (void)setFieldType:(UITextFieldToolType)fieldType {
    _fieldType = fieldType;
    switch (_fieldType) {
        case UITextFieldToolNormal:
        {
            self.keyboardType = UIKeyboardTypeDefault;
        }
            break;
        case UITextFieldToolNumber:
        {
            self.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case UITextFieldToolCharacter:
        case UITextFieldToolNumberCharacter:
        case UITextFieldToolNonChinese:
        {
            self.keyboardType = UIKeyboardTypeASCIICapable;
        }
            break;
        default:
            break;
    }
}
- (void)setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    self.placeholder = placeholderStr;
    if (self.placeholderColor) {
        self.placeholderColor = self.placeholderColor;
    } else {
        self.placeholderColor = [UIColor color_999999];
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    NSString *placeholderStr = self.placeholderStr;
    if (!placeholderStr) {
        placeholderStr = @"";
    }
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderStr attributes:@{NSForegroundColorAttributeName: placeholderColor}];

}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.font = titleFont;
}

@end
