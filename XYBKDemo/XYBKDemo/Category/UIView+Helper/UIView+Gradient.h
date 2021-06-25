//
//  UIView+Gradient.h
//  cwz51
//
//  Created by 陈晓 on 2021/6/4.
//  Copyright © 2021 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 渐变 */
@interface UIView (Gradient)

- (void)addGradientLayerWithFrame:(CGRect)rect Colors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
