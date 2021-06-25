//
//  UIImageView+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2020/10/15.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "UIImageView+Helper.h"

@implementation UIImageView (Helper)

- (instancetype)initContentModeScaleAspectFit {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (instancetype)initContentModeScaleAspectFitWithImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.image = [UIImage imageNamed:imageName];
    }
    return self;
}
- (instancetype)initContentModeScaleAspectFill {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}
- (instancetype)initContentModeCenterWithImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        self.image = [UIImage imageNamed:imageName];
    }
    return self;
}
- (instancetype)initStretchableImageViewWithImageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.image = [UIImage getStretchableImageWithImageName:imageName];
    }
    return self;
}

/** 门店logo */
- (instancetype)initShopLogoImageView {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
    }
    return self;
}


@end
