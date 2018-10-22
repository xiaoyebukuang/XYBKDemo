//
//  UILabel+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

- (instancetype)initWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.font = font;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.font = font;
    }
    return self;
}

- (instancetype)initWithTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.font = font;
        self.textAlignment = textAlignment;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.textAlignment = textAlignment;
        self.font = font;
    }
    return self;
}
@end
