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


@implementation UIColor (Helper)
+ (UIColor *)color_random {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
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
+ (UIColor *)color_main {
    UIColor *color = [self color_F8F8F8];
    return color;
}
/** 橘色 */
+ (UIColor *)color_FF712C {
    UIColor *color = UIColorFromRGB(0xFF712C);
    return color;
}
+ (UIColor *)color_FF712C_5 {
    UIColor *color = COLOR_RGB_ALPHA(0xFF712C,0.5);
    return color;
}
+ (UIColor *)color_FF712C_3 {
    UIColor *color = COLOR_RGB_ALPHA(0xFF712C,0.3);
    return color;
}
+ (UIColor *)color_FF712C_04 {
    UIColor *color = COLOR_RGB_ALPHA(0xFF7E3F,0.04);
    return color;
}
+ (UIColor *)color_FF5400 {
    UIColor *color = UIColorFromRGB(0xFF5400);
    return color;
}
/** 主题颜色 */
+ (UIColor *)color_000000 {
    UIColor *color = UIColorFromRGB(0x000000);
    return color;
}
+ (UIColor *)color_000000_1 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.1);
    return color;
}
+ (UIColor *)color_000000_3 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.3);
    return color;
}
+ (UIColor *)color_000000_5 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.5);
    return color;
}
+ (UIColor *)color_000000_6 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.6);
    return color;
}
+ (UIColor *)color_000000_8 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.8);
    return color;
}
+ (UIColor *)color_222222 {
    UIColor *color = UIColorFromRGB(0x222222);
    return color;
}
+ (UIColor *)color_444444 {
    UIColor *color = UIColorFromRGB(0x444444);
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
+ (UIColor *)color_FFFFFF_0 {
    UIColor *color = COLOR_RGB_ALPHA(0xFFFFFF,0);
    return color;
}
+ (UIColor *)color_FFFFFF_3 {
    UIColor *color = COLOR_RGB_ALPHA(0xFFFFFF,0.3);
    return color;
}
+ (UIColor *)color_FFFFFF_5 {
    UIColor *color = COLOR_RGB_ALPHA(0xFFFFFF,0.5);
    return color;
}
+ (UIColor *)color_FFFFFF_9 {
    UIColor *color = COLOR_RGB_ALPHA(0xFFFFFF,0.9);
    return color;
}
/** 提示信息/问题图标 */
+ (UIColor *)color_2C7BFC {
    UIColor *color = UIColorFromRGB(0x2C7BFC);
    return color;
}
/** 背景色/模块区分色 */
+ (UIColor *)color_F8F8F8 {
    UIColor *color = UIColorFromRGB(0xF8F8F8);
    return color;
}
+ (UIColor *)color_FDFDFD {
    UIColor *color = UIColorFromRGB(0xFDFDFD);
    return color;
}
+ (UIColor *)color_FF0000 {
    UIColor *color = UIColorFromRGB(0xFF0000);
    return color;
}
+ (UIColor *)color_FAFBFC {
    UIColor *color = UIColorFromRGB(0xFAFBFC);
    return color;
}
/** 跑马灯背景 */
+ (UIColor *)color_FFFCE8 {
    UIColor *color = UIColorFromRGB(0xFFFCE8);
    return color;
}
/** 提示背景色 */
+ (UIColor *)color_FFF4EB {
    UIColor *color = UIColorFromRGB(0xFFF4EB);
    return color;
}
/** 标签选中背景色 */
+ (UIColor *)color_FFF7F3 {
    UIColor *color = UIColorFromRGB(0xFFF7F3);
    return color;
}
/** 线框颜色 */
+ (UIColor *)color_F7F7F7 {
    UIColor *color = UIColorFromRGB(0xF7F7F7);
    return color;
}
+ (UIColor *)color_BBBBBB {
    UIColor *color = UIColorFromRGB(0xBBBBBB);
    return color;
}
+ (UIColor *)color_EEEEF0 {
    UIColor *color = UIColorFromRGB(0xEEEEF0);
    return color;
}
+ (UIColor *)color_F2F2F2 {
    UIColor *color = UIColorFromRGB(0xF2F2F2);
    return color;
}
+ (UIColor *)color_FDC802 {
    UIColor *color = UIColorFromRGB(0xFDC802);
    return color;
}
+ (UIColor *)color_F0F0F0 {
    UIColor *color = UIColorFromRGB(0xF0F0F0);
    return color;
}
+ (UIColor *)color_EEEEEE {
    UIColor *color = UIColorFromRGB(0xEEEEEE);
    return color;
}
+ (UIColor *)color_EEEEEE_4 {
    UIColor *color = COLOR_RGB_ALPHA(0xEEEEEE,0.4);
    return color;
}
/** 按钮至灰状态颜色/未选中框的颜色/不可点击/其它/图标颜色 */
+ (UIColor *)color_CCCCCC {
    UIColor *color = UIColorFromRGB(0xCCCCCC);
    return color;
}
/** 价格 */
+ (UIColor *)color_FF3F40 {
    UIColor *color = UIColorFromRGB(0xFF3F40);
    return color;
}
+ (UIColor *)color_FF3F40_5 {
    UIColor *color = COLOR_RGB_ALPHA(0xFF3F40,0.5);
    return color;
}
+ (UIColor *)color_48BB04 {
    UIColor *color = UIColorFromRGB(0x48BB04);
    return color;
}
+ (UIColor *)color_FF3F3F {
    UIColor *color = UIColorFromRGB(0xFF3F3F);
    return color;
}
/** 阴影 */
+ (UIColor *)color_CECECE_32 {
    UIColor *color = COLOR_RGB_ALPHA(0xCECECE,0.32);
    return color;
}
+ (UIColor *)color_FF6F84_4 {
    UIColor *color = COLOR_RGB_ALPHA(0xFF6F84,0.4);
    return color;
}
/** 页码颜色 */
+ (UIColor *)color_3775F4 {
    UIColor *color = UIColorFromRGB(0x3775F4);
    return color;
}
/** 我的油卡 */
+ (UIColor *)color_FAFAFC {
    UIColor *color = UIColorFromRGB(0xFAFAFC);
    return color;
}
+ (UIColor *)color_FAFAFA {
    UIColor *color = UIColorFromRGB(0xFAFAFA);
    return color;
}
/** 券包 */
+ (UIColor *)color_894F1B {
    UIColor *color = UIColorFromRGB(0x894F1B);
    return color;
}
+ (UIColor *)colro_FFFAF1 {
    UIColor *color = UIColorFromRGB(0xFFFAF1);
    return color;
}
/** 代金券 */
+ (UIColor *)color_C5C5C5 {
    UIColor *color = UIColorFromRGB(0xC5C5C5);
    return color;
}
+ (UIColor *)color_644830 {
    UIColor *color = UIColorFromRGB(0x644830);
    return color;
}
+ (UIColor *)color_644830_7 {
    UIColor *color = COLOR_RGB_ALPHA(0x644830,0.7);
    return color;
}
+ (UIColor *)color_A08565 {
    UIColor *color = UIColorFromRGB(0xA08565);
    return color;
}
+ (UIColor *)color_806546 {
    UIColor *color = UIColorFromRGB(0x806546);
    return color;
}
+ (UIColor *)color_FFF1D4 {
    UIColor *color = UIColorFromRGB(0xFFF1D4);
    return color;
}
/** 违章代缴 */
+ (UIColor *)color_01C34D {
    UIColor *color = UIColorFromRGB(0x01C34D);
    return color;
}
+ (UIColor *)color_FEFDEB {
    UIColor *color = UIColorFromRGB(0xFEFDEB);
    return color;
}
/** 小保养 */
+ (UIColor *)color_FFFAF1 {
    UIColor *color = UIColorFromRGB(0xFFFAF1);
    return color;
}
/** 个人中心 */
+ (UIColor *)color_FAFDFE {
    UIColor *color = UIColorFromRGB(0xFAFDFE);
    return color;
}
/** 我的爱车 */
+ (UIColor *)color_F5F5F5 {
    UIColor *color = UIColorFromRGB(0xF5F5F5);
    return color;
}
+ (UIColor *)color_EAEBEC {
    UIColor *color = UIColorFromRGB(0xEAEBEC);
    return color;
}
/** 门店服务 */
+ (UIColor *)color_A0A0A0 {
    UIColor *color = UIColorFromRGB(0xA0A0A0);
    return color;
}
+ (UIColor *)color_DDDDDD {
    UIColor *color = UIColorFromRGB(0xDDDDDD);
    return color;
}
+ (UIColor *)color_666666_86 {
    UIColor *color = COLOR_RGB_ALPHA(0x666666,0.86);
    return color;
}
/** 退款页面 */
+ (UIColor *)color_FF5000 {
    UIColor *color = UIColorFromRGB(0xFF5000);
    return color;
}
+ (UIColor *)color_FF7C7C {
    UIColor *color = UIColorFromRGB(0xFF7C7C);
    return color;
}
/** 会员颜色 */
+ (UIColor *)color_EE8636 {
    UIColor *color = UIColorFromRGB(0xEE8636);
    return color;
}
/** 渐变颜色 */
+ (UIColor *)color_FF4945 {
    UIColor *color = UIColorFromRGB(0xFF4945);
    return color;
}
+ (UIColor *)color_FF784B {
    UIColor *color = UIColorFromRGB(0xFF4945);
    return color;
}
+ (UIColor *)color_FCE6E2 {
    UIColor *color = UIColorFromRGB(0xFCE6E2);
    return color;
}
+ (UIColor *)color_F9F9F9 {
    UIColor *color = UIColorFromRGB(0xF9F9F9);
    return color;
}
+ (UIColor *)color_FFCF7E {
    UIColor *color = UIColorFromRGB(0xFFCF7E);
    return color;
}
+ (UIColor *)color_FFB154 {
    UIColor *color = UIColorFromRGB(0xFFB154);
    return color;
}
+ (UIColor *)color_FFE6D3 {
    UIColor *color = UIColorFromRGB(0xFFE6D3);
    return color;
}
+ (UIColor *)color_F4BF97 {
    UIColor *color = UIColorFromRGB(0xF4BF97);
    return color;
}
+ (UIColor *)color_774510 {
    UIColor *color = UIColorFromRGB(0x774510);
    return color;
}
+ (UIColor *)color_CFA273 {
    UIColor *color = UIColorFromRGB(0xCFA273);
    return color;
}
+ (UIColor *)color_FF9C52 {
    UIColor *color = UIColorFromRGB(0xFF9C52);
    return color;
}
+ (UIColor *)color_FF5A07 {
    UIColor *color = UIColorFromRGB(0xFF5A07);
    return color;
}
+ (UIColor *)color_FF3A30 {
    UIColor *color = UIColorFromRGB(0xFF3A30);
    return color;
}
+ (UIColor *)color_FE6B2E {
    UIColor *color = UIColorFromRGB(0xFE6B2E);
    return color;
}
+ (UIColor *)color_FF9B0A {
    UIColor *color = UIColorFromRGB(0xFF9B0A);
    return color;
}
+ (UIColor *)color_FF630B {
    UIColor *color = UIColorFromRGB(0xFF630B);
    return color;
}
+ (UIColor *)color_FFD140 {
    UIColor *color = UIColorFromRGB(0xFFD140);
    return color;
}
+ (UIColor *)color_FF6E1C {
    UIColor *color = UIColorFromRGB(0xFF6E1C);
    return color;
}
















+ (UIColor *)color_232323 {
    UIColor *color = UIColorFromRGB(0x232323);
    return color;
}
+ (UIColor *)color_E6E6E6 {
    UIColor *color = UIColorFromRGB(0xE6E6E6);
    return color;
}
+ (UIColor *)color_EB5846 {
    UIColor *color = UIColorFromRGB(0xEB5846);
    return color;
}


+ (UIColor *)color_F6F6F6 {
    UIColor *color = UIColorFromRGB(0xF6F6F6);
    return color;
}
+ (UIColor *)color_454545_9 {
    UIColor *color = COLOR_RGB_ALPHA(0x454545,0.9);
    return color;
}
+ (UIColor *)color_E5E5E5 {
    UIColor *color = UIColorFromRGB(0xE5E5E5);
    return color;
}
+ (UIColor *)color_CBCBCB {
    UIColor *color = UIColorFromRGB(0xCBCBCB);
    return color;
}
+ (UIColor *)color_FF641F {
    UIColor *color = UIColorFromRGB(0xFF641F);
    return color;
}



@end
