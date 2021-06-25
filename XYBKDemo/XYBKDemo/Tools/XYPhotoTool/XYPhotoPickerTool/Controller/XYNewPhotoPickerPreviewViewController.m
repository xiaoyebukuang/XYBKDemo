//
//  XYNewPhotoPickerPreviewViewController.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYNewPhotoPickerPreviewViewController.h"
#import "XYNewPhotoPickerPreviewCollectionViewCell.h"

static NSString * const XYNewPhotoPickerPreviewCollectionViewCellID = @"XYNewPhotoPickerPreviewCollectionViewCellID";

@interface XYNewPhotoPickerPreviewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 底部view */
@property (nonatomic, strong) UIView *bottomView;
/** 完成按钮 */
@property (nonatomic, strong) UIButton *finishBtn;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XYNewPhotoPickerPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"相册";
    self.view.backgroundColor = [UIColor color_000000];
    [self setupUI];
    [self reloadView];
}
- (void)setupUI {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(kAssetsBottomHeight + IPHONEX_BOTTOW_HEIGHT);
    }];
    [self.view addSubview:self.collectionView];
}
- (void)reloadView {
    if (self.selectPickerAssets.count == 0) {
        self.finishBtn.alpha = 0.3;
        self.finishBtn.enabled = NO;
    } else {
        self.finishBtn.alpha = 1;
        self.finishBtn.enabled = YES;
    }
}
/** 点击完成 */
- (void)finishBtnBtnEvent:(UIButton *)sender {
    /** 发送通知 */
    [MBProgressHUD showWindow];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[XYPhotoPickerDatas defaultPicker]getImagesFromPHAsset:self.selectPickerAssets callBack:^(NSArray<UIImage *> *images) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                if (self.callBlock) {
                    self.callBlock(images);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    });
}
#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
/** 行数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assetsArray.count;
}
/** cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYNewPhotoPickerPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYNewPhotoPickerPreviewCollectionViewCellID forIndexPath:indexPath];
    id assetModel = self.assetsArray[indexPath.row];
    NSUInteger index = [self.selectPickerAssets indexOfObject:assetModel];
    WeakSelf;
    [cell reloadDataWithModel:assetModel indexPath:index photoPickerSelectedBlock:^(BOOL isSelected) {
        if (isSelected) {
            if (weakSelf.selectPickerAssets.count >= weakSelf.maxCount) {
                /** 超过限制个数，提示 */
                NSString *title = [NSString stringWithFormat:@"图片最多选取%d张",(int)weakSelf.maxCount];
                [MBProgressHUD showError:title];
            } else {
                /** 没有超过限制个数，直接添加 */
                [weakSelf.selectPickerAssets addObject:assetModel];
                [cell reloadSelectedWithIsSelected:YES];
                [weakSelf reloadView];
            }
        } else {
            /** 从添加的数组中移除 */
            [weakSelf.selectPickerAssets removeObject:assetModel];
            [cell reloadSelectedWithIsSelected:NO];
            [weakSelf reloadView];
        }
    }];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGFloat collection_height = MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT - IPHONEX_BOTTOW_HEIGHT - kAssetsBottomHeight;
    return CGSizeMake(XYColletionViewLineSpacing, collection_height);
}
#pragma mark -- setup
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat collection_height = MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT - IPHONEX_BOTTOW_HEIGHT - kAssetsBottomHeight;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = XYColletionViewLineSpacing;
        flowLayout.minimumInteritemSpacing = XYColletionViewInteritemSpacing;
        flowLayout.itemSize = CGSizeMake(MAIN_SCREEN_WIDTH, collection_height);
        //支持横向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH + XYColletionViewLineSpacing,collection_height) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XYNewPhotoPickerPreviewCollectionViewCell class] forCellWithReuseIdentifier:XYNewPhotoPickerPreviewCollectionViewCellID];
        if (@available(iOS 11.0,*)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        if (self.assetsArray.count > self.currentPage) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
    }
    return _collectionView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor color_FFFFFF];
        UIView *topView = [[UIView alloc]init];
        [view addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.top.equalTo(view);
            make.height.mas_equalTo(kNewAssetsBottomHeight);
        }];
        [view addSubview:self.finishBtn];
        [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(view).mas_offset(-12);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        _bottomView = view;
    }
    return _bottomView;
}
- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithTitle:@"完成" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_15];
        _finishBtn.backgroundColor = [UIColor color_FF5400];
        _finishBtn.layer.cornerRadius = 15;
        _finishBtn.layer.masksToBounds = YES;
        _finishBtn.alpha = 0.3;
        _finishBtn.enabled = NO;
        [_finishBtn addTarget:self action:@selector(finishBtnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

@end
