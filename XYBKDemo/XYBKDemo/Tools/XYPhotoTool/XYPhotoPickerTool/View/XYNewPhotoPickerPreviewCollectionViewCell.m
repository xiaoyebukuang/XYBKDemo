//
//  XYNewPhotoPickerPreviewCollectionViewCell.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYNewPhotoPickerPreviewCollectionViewCell.h"

@interface XYNewPhotoPickerPreviewCollectionViewCell()

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, copy) XYNewPhotoPickerSelectedBlock selectedBlock;
@end

@implementation XYNewPhotoPickerPreviewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self.contentView addSubview:self.photoBrowserScrollView];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.top.equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(30);
    }];
}
- (void)reloadDataWithModel:(id)assetModel indexPath:(NSUInteger)index photoPickerSelectedBlock:(XYNewPhotoPickerSelectedBlock)selectedBlock {
    self.selectedBlock = selectedBlock;
    BOOL isSelect = NO;
    if (index != NSNotFound) {
        isSelect = YES;
    }
    self.selectBtn.selected = isSelect;
    [self.photoBrowserScrollView reloadViewWithModel:assetModel placeholderImage:nil];
}
- (void)reloadSelectedWithIsSelected:(BOOL)isSelected {
    self.selectBtn.selected = isSelected;
}
#pragma mark -- event
- (void)selectBtnEvent:(UIButton *)sender {
    if (self.selectedBlock) {
        self.selectedBlock(!sender.selected);
    }
}
#pragma mark -- setup
- (XYPhotoBrowserScrollView *)photoBrowserScrollView {
    if (!_photoBrowserScrollView) {
        _photoBrowserScrollView = [[XYPhotoBrowserScrollView alloc] initWithFrame:self.bounds];
        _photoBrowserScrollView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0,*)) {
            _photoBrowserScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _photoBrowserScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _photoBrowserScrollView;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithImage:@"new_assets_normal" selectedImage:@"new_assets_selected"];
        [_selectBtn addTarget:self action:@selector(selectBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

@end
