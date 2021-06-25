//
//  UIView+Corner.h
//  cwz51
//
//  Created by 陈晓 on 2020/9/4.
//  Copyright © 2020 XYBK. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)

/** 是否需要添加圆角 */
@property (nonatomic, assign) BOOL hasRound;
/** 圆角大小 */
@property (nonatomic) CGFloat radius;
/** 添加圆角的位置 */
@property (nonatomic, assign) UIRectCorner rectCorners;


/** 添加左右圆角 */
- (void)addRoundedCorners:(UIRectCorner)rectCorners withCornerRadius:(CGFloat)radius;

/** 添加左上和右上圆角 */
- (void)addTopLeftAndTopRightRoundedCornersWithCornerRadius:(CGFloat)radius;

/** 添加全部圆角 */
- (void)addAllRoundedWithCornerRadius:(CGFloat)cornerRadius;

/** 添加全部半圆角 */
- (void)addAllCircular;


@end

NS_ASSUME_NONNULL_END
