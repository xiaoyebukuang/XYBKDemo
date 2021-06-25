

//
//  UIView+Corner.m
//  cwz51
//
//  Created by 陈晓 on 2020/9/4.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "UIView+Corner.h"
#import <objc/runtime.h>


static NSString * const UIViewRectCornersKey = @"UIViewRectCornersKey";
static NSString * const UIViewCornerRadiusKey = @"UIViewCornerRadiusKey";
static NSString * const UIViewHasRoundKey = @"UIViewHasRoundKey";


@implementation UIView (Corner)

- (void)setHasRound:(BOOL)hasRound {
    objc_setAssociatedObject(self, &UIViewHasRoundKey, @(hasRound), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)hasRound {
    NSNumber *number = objc_getAssociatedObject(self, &UIViewHasRoundKey);
    return number.boolValue;
}
- (void)setRadius:(CGFloat)radius {
    objc_setAssociatedObject(self, &UIViewCornerRadiusKey, @(radius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)radius {
    NSNumber *number = objc_getAssociatedObject(self, &UIViewCornerRadiusKey);
    return number.floatValue;
}
- (void)setRectCorners:(UIRectCorner)rectCorners {
    objc_setAssociatedObject(self, &UIViewRectCornersKey, @(rectCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIRectCorner)rectCorners {
    NSNumber *number = objc_getAssociatedObject(self, &UIViewRectCornersKey);
    return number.integerValue;
}
+ (void)load {
    SEL oldSel = @selector(layoutSublayersOfLayer:);
    SEL newSel = @selector(xy_layoutSublayersOfLayer:);
    
    Method oldMethod = class_getInstanceMethod(self, oldSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    
    method_exchangeImplementations(oldMethod, newMethod);
}
- (void)xy_layoutSublayersOfLayer:(CALayer *)layer {
    [self xy_layoutSublayersOfLayer:layer];
    if (self.hasRound) {
        CGSize cornerRadii;
        if (self.radius == 0) {
            cornerRadii = CGSizeMake(self.height/2.0,self.height/2.0);
        } else {
            cornerRadii = CGSizeMake(self.radius, self.radius);
        }
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.rectCorners cornerRadii:cornerRadii];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        self.layer.mask = shape;
    }
}
- (void)addTopLeftAndTopRightRoundedCornersWithCornerRadius:(CGFloat)radius {
    [self addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight withCornerRadius:radius];
}
- (void)addAllRoundedWithCornerRadius:(CGFloat)cornerRadius {
    [self addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight withCornerRadius:cornerRadius];
}
- (void)addAllCircular {
    [self addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight withCornerRadius:0];
}
- (void)addRoundedCorners:(UIRectCorner)rectCorners withCornerRadius:(CGFloat)radius {
    self.hasRound = YES;
    self.radius = radius;
    self.rectCorners = rectCorners;
}
@end
