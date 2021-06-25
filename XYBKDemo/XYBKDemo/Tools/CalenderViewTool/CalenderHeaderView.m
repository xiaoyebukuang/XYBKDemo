//
//  CalenderHeaderView.m
//  cwz51
//
//  Created by 陈晓 on 2019/6/6.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "CalenderHeaderView.h"

@implementation CalenderHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yearAndMonthLabel];
        [self.yearAndMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
- (UILabel *)yearAndMonthLabel {
    if (!_yearAndMonthLabel) {
        _yearAndMonthLabel = [[UILabel alloc]initWithTextColor:[UIColor color_222222] font:SYSTEM_FONT_15];
    }
    return _yearAndMonthLabel;
}


@end
