//
//  UIImageView+Helper.h
//  cwz51
//
//  Created by 陈晓 on 2020/10/15.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Helper)

- (instancetype)initContentModeScaleAspectFit;

- (instancetype)initContentModeScaleAspectFitWithImageName:(NSString *)imageName;

- (instancetype)initContentModeScaleAspectFill;

- (instancetype)initContentModeCenterWithImageName:(NSString *)imageName;

- (instancetype)initStretchableImageViewWithImageName:(NSString *)imageName;

/** 门店logo */
- (instancetype)initShopLogoImageView;

@end

NS_ASSUME_NONNULL_END
