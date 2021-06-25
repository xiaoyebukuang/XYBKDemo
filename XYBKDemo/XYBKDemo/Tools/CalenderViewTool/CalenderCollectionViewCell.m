//
//  CalenderCollectionViewCell.m
//  cwz51
//
//  Created by 陈晓 on 2019/6/6.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "CalenderCollectionViewCell.h"

@interface CalenderCollectionViewCell()

@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation CalenderCollectionViewCell

-(void)setupUI {
    [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.height.mas_equalTo(35);
    }];
}
- (void)setCalenderModel:(CalenderModel *)calenderModel {
    _calenderModel = calenderModel;
    self.numberLabel.text = calenderModel.showDay;
    self.numberLabel.textColor = calenderModel.isSelected?calenderModel.selectedColor:calenderModel.normalColor;
    if (calenderModel.isDate) {
        self.numberLabel.backgroundColor = calenderModel.isSelected?calenderModel.selectedBGColor:calenderModel.normalBGColor;
    } else {
        self.numberLabel.backgroundColor = [UIColor clearColor];
    }
    if (calenderModel.isSelected) {
        [self addAnimaiton];
    }
}
- (void)addAnimaiton {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.values = @[@0.6,@1.2,@1.0];
    anim.keyPath = @"transform.scale";  // transform.scale 表示长和宽都缩放
    anim.calculationMode = kCAAnimationPaced;
    anim.duration = 0.25;
    [self.numberLabel.layer addAnimation:anim forKey:nil];
}
#pragma mark -- setup
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithTextColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.layer.cornerRadius = 35/2;
        _numberLabel.layer.masksToBounds = YES;
    }
    return _numberLabel;
}
@end
