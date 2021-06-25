//
//  XYNewPhotoPickerAssetsCollectionViewCell.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYNewPhotoPickerAssetsCollectionViewCell.h"

@interface XYNewPhotoPickerAssetsCollectionViewCell()


@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIImageView *cameraImageV;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, copy) XYNewPhotoPickerSelectedBlock selectedBlock;

@end


@implementation XYNewPhotoPickerAssetsCollectionViewCell

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
    [self.contentView addSubview:self.cameraImageV];
    [self.cameraImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(30);
    }];
}
- (void)reloadCamera {
    self.selectBtn.hidden = YES;
    self.imageV.hidden = YES;
    self.cameraImageV.hidden = NO;
}
- (void)reloadDataWithModel:(id)assetModel indexPath:(NSUInteger)index photoPickerSelectedBlock:(XYNewPhotoPickerSelectedBlock)selectedBlock {
    self.selectBtn.hidden = NO;
    self.imageV.hidden = NO;
    self.cameraImageV.hidden = YES;
    BOOL isSelect = NO;
    if (index != NSNotFound) {
        isSelect = YES;
    }
    self.selectBtn.selected = isSelect;
    self.selectedBlock = selectedBlock;
    if ([assetModel isKindOfClass:[PHAsset class]]) {
        PHAsset *asset = assetModel;
        [[XYPhotoPickerDatas defaultPicker]cachingImageForAsset:asset targetSize:CGSizeMake(kAssetsRowWidth, kAssetsRowHeight) callBack:^(UIImage *image) {
            self.imageV.image = image;
        }];
    } else if ([assetModel isKindOfClass:[UIImage class]]) {
        UIImage *image = assetModel;
        self.imageV.image = image;
    }
}
#pragma mark -- event
- (void)selectBtnEvent:(UIButton *)sender {
    if (self.selectedBlock) {
        self.selectedBlock(!sender.selected);
    }
}
#pragma mark -- setup
- (UIImageView *)cameraImageV {
    if (!_cameraImageV) {
        _cameraImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_assets_camera"]];
        _cameraImageV.contentMode = UIViewContentModeCenter;
        _cameraImageV.layer.cornerRadius = 5;
        _cameraImageV.layer.masksToBounds = YES;
        _cameraImageV.backgroundColor = [UIColor color_000000];
    }
    return _cameraImageV;
}
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.cornerRadius = 5;
        _imageV.layer.masksToBounds = YES;
    }
    return _imageV;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithImage:@"new_assets_normal" selectedImage:@"new_assets_selected"];
        [_selectBtn addTarget:self action:@selector(selectBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


@end
