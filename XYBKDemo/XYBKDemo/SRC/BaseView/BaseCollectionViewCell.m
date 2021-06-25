//
//  BaseCollectionViewCell.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
/** 交给子类创建view */
- (void)setupUI {
    
}

@end
