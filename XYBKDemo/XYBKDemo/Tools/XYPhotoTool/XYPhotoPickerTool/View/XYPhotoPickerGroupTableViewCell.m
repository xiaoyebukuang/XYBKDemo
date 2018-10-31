//
//  XYPhotoPickerGroupTableViewCell.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerGroupTableViewCell.h"
#import "XYPhotoToolMacros.h"
@interface XYPhotoPickerGroupTableViewCell()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *countL;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation XYPhotoPickerGroupTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor color_FFFFFF];
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self.contentView addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_offset(kAlbumRowWidth);
        make.height.mas_offset(kAlbumRowHeight);
    }];
    
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).mas_offset(15);
        make.centerY.equalTo(self.imageV);
    }];
    [self.contentView addSubview:self.countL];
    [self.countL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL.mas_right).mas_offset(15);
        make.centerY.equalTo(self.imageV);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)setPickerGroup:(XYPhotoPickerGroup *)pickerGroup {
    _pickerGroup = pickerGroup;
    self.imageV.image = pickerGroup.thumbImage;
    self.titleL.text = pickerGroup.groupName;
    self.countL.text = [NSString stringWithFormat:@"(%ld)",pickerGroup.assetsCount];
}

#pragma mark -- setupUI

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
    }
    return _imageV;
}
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_14];
    }
    return _titleL;
}
- (UILabel *)countL {
    if (!_countL) {
        _countL = [[UILabel alloc]initWithTextColor:[UIColor color_666666] font:SYSTEM_FONT_14];
    }
    return _countL;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}


@end
