//
//  UIColor+Helper.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/20.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIColor+Helper.h"

/** 获取颜色 */
//16进制颜色定义
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_RGB_ALPHA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]
//rgb颜色
#define RGB(r,g,b)                  RGBA(r,g,b,1.0f)
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@implementation UIColor (Helper)

+ (UIColor *)color_hex:(NSString *)hex {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+ (UIColor *)color_random {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
+ (UIColor *)color_333333 {
    UIColor *color = UIColorFromRGB(0x333333);
    return color;
}
+ (UIColor *)color_666666 {
    UIColor *color = UIColorFromRGB(0x666666);
    return color;
}
+ (UIColor *)color_999999 {
    UIColor *color = UIColorFromRGB(0x999999);
    return color;
}
+ (UIColor *)color_FFFFFF {
    UIColor *color = UIColorFromRGB(0xFFFFFF);
    return color;
}
+ (UIColor *)color_000000 {
    UIColor *color = UIColorFromRGB(0x000000);
    return color;
}
+ (UIColor *)color_000000_3 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.3);
    return color;
}
+ (UIColor *)color_F7F7F7 {
    UIColor *color = UIColorFromRGB(0xF7F7F7);
    return color;
}
+ (UIColor *)color_F0F0F0 {
    UIColor *color = UIColorFromRGB(0xF0F0F0);
    return color;
}
+ (UIColor *)color_232323 {
    UIColor *color = UIColorFromRGB(0x232323);
    return color;
}
@end
