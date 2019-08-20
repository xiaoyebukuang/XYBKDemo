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

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor  textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.textAlignment = textAlignment;
        self.font = font;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.textAlignment = textAlignment;
        self.font = font;
        [self reloadTitleWithTitle:text lineSpacing:lineSpacing textAlignment:textAlignment];
    }
    return self;
}
- (void)reloadTitleWithTitle:(NSString *)title lineSpacing:(CGFloat)lineSpacing textAlignment:(NSTextAlignment)textAlignment {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = textAlignment;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
@end
