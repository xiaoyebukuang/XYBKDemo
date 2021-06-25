//
//  UILabel+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UILabel+Helper.h"
#import <objc/runtime.h>

@implementation UILabel (Helper)

+ (void)load {
    SEL oldSel = @selector(setText:);
    SEL newSel = @selector(xy_setText:);
    
    Method oldMethod = class_getInstanceMethod(self, oldSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    
    method_exchangeImplementations(oldMethod, newMethod);
}
- (void)xy_setText:(NSString *)text {
    if (self.xy_LineSpace == 0) {
        [self xy_setText:text];
    } else {
        [self reloadTitleWithTitle:text lineSpacing:self.xy_LineSpace textAlignment:self.textAlignment];
    }
}

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
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment
                        font:(UIFont *)font
                 lineSpacing:(CGFloat)lineSpacing {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.textAlignment = textAlignment;
        self.font = font;
        self.xy_LineSpace = lineSpacing;
        [self reloadTitleWithTitle:text lineSpacing:lineSpacing textAlignment:textAlignment];
    }
    return self;
}
- (instancetype)initWithTextColor:(UIColor *)textColor
                             font:(UIFont *)font
                      lineSpacing:(CGFloat)lineSpacing {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.font = font;
        self.xy_LineSpace = lineSpacing;
    }
    return self;
}
- (void)setXy_LineSpace:(CGFloat)xy_LineSpace {
    if (self.xy_LineSpace == xy_LineSpace) return;
    objc_setAssociatedObject(self, @selector(xy_LineSpace), @(xy_LineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)xy_LineSpace {
    NSNumber *xy_LineSpace = objc_getAssociatedObject(self, @selector(xy_LineSpace));
    if (!xy_LineSpace) {
        return 0;
    }
    return xy_LineSpace.floatValue;
}
- (void)reloadTitleWithTitle:(NSString *)title {
    [self reloadTitleWithTitle:title lineSpacing:self.xy_LineSpace];
}
- (void)reloadTitleWithTitle:(NSString *)title lineSpacing:(CGFloat)lineSpacing textAlignment:(NSTextAlignment)textAlignment {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (void)reloadTitleWithTitle:(NSString *)title lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


@end
