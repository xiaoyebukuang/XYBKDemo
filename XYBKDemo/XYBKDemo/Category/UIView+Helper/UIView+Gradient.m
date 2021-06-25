//
//  UIView+Gradient.m
//  cwz51
//
//  Created by 陈晓 on 2021/6/4.
//  Copyright © 2021 XYBK. All rights reserved.
//

#import "UIView+Gradient.h"
#import <objc/runtime.h>

@implementation UIView (Gradient)

- (void)addGradientLayerWithFrame:(CGRect)rect Colors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *xy_gradientLayer = [CAGradientLayer layer];
    xy_gradientLayer.colors = colors;
    xy_gradientLayer.locations = locations;
    xy_gradientLayer.startPoint = startPoint;
    xy_gradientLayer.endPoint = endPoint;
    xy_gradientLayer.frame = rect;
    [self.layer insertSublayer:xy_gradientLayer atIndex:0];
}
@end
