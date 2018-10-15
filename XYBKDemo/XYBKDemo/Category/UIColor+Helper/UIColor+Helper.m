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

@end
