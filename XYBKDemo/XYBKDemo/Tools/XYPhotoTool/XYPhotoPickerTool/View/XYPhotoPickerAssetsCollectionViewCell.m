//
//  XYPhotoPickerAssetsCollectionViewCell.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerAssetsCollectionViewCell.h"
#import "XYPhotoToolMacros.h"
@interface XYPhotoPickerAssetsCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, copy) XYPhotoPickerAssetsBlock assetsBlock;
@end

@implementation XYPhotoPickerAssetsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self.contentView addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-5);
        make.top.equalTo(self.contentView).mas_offset(5);
    }];
}
- (void)reloadDataWithPHAssets:(PHAsset *)asset indexPath:(NSUInteger)index photoPickerAssetsBlock:(XYPhotoPickerAssetsBlock)assetsBlock {
    BOOL isSelect = NO;
    if (index != NSNotFound) {
        isSelect = YES;
    }
    self.selectBtn.selected = isSelect;
    if (isSelect) {
        [self.selectBtn setTitle:[NSString stringWithFormat:@"%ld",index+1] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setTitle:@"" forState:UIControlStateNormal];
    }
    self.assetsBlock = assetsBlock;
    [[XYPhotoPickerDatas defaultPicker]cachingImageForAsset:asset targetSize:CGSizeMake(kAssetsRowWidth, kAssetsRowHeight) callBack:^(UIImage *image) {
        self.imageV.image = image;
    }];
}
#pragma mark -- setup
- (void)selectBtnEvent:(UIButton *)sender {
    if (self.assetsBlock) {
        self.assetsBlock(!sender.selected);
    }
}
#pragma mark -- setup
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
    }
    return _imageV;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithBGImage:@"assets_normal" selectBGImage:(NSString *)@"assets_selected" title:@"" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
        [_selectBtn addTarget:self action:@selector(selectBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


@end
