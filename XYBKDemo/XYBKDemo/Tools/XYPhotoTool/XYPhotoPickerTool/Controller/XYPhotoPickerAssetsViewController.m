//
//  XYPhotoPickerAssetsViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerAssetsViewController.h"
#import "XYPhotoPickerAssetsCollectionViewCell.h"
#import "XYPhotoPickerPreviewViewController.h"
#import "XYPhotoPickerAsset.h"

#import "XYPhotoBrowserViewController.h"

/** 一行的个数 */
static const NSInteger assets_cell_number = 4;
/** 内边距 */
static const CGFloat assets_inset_top = 5.0f;
static const CGFloat assets_inset_left = 5.0f;
static const CGFloat assets_inset_bottom = 5.0f;
static const CGFloat assets_inset_right = 5.0f;
/** 列间距 */
static const CGFloat assets_interitem_spacing = 5.0f;
/** 行间距 */
static const CGFloat assets_line_spacing = 5.0f;

static NSString * const XYPhotoPickerAssetsCollectionViewCellID = @"XYPhotoPickerAssetsCollectionViewCellID";

@interface XYPhotoPickerAssetsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 底部view */
@property (nonatomic, strong) UIView *bottomView;
/** 预览按钮 */
@property (nonatomic, strong) UIButton *previewBtn;
/** 完成按钮 */
@property (nonatomic, strong) UIButton *finishBtn;
/** 数据源 */
@property (nonatomic, strong) NSArray <XYPhotoPickerAsset *>*assetsArray;
/** 选中的数据 */
@property (nonatomic, strong) NSMutableArray <XYPhotoPickerAsset *>*selectPickerAssets;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat assets_cell_size;

@end

@implementation XYPhotoPickerAssetsViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self reloadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_FFFFFF];
    self.selectPickerAssets = [NSMutableArray array];
    if (self.pickerGroup) {
        self.title = self.pickerGroup.groupName;
    }
    if (self.subtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
        self.title = @"相机胶卷";
    }
    self.assets_cell_size = (MAIN_SCREEN_WIDTH - assets_inset_left - assets_inset_right - (assets_cell_number - 1)*assets_interitem_spacing)/assets_cell_number;
    [self setupUI];
    [self setNavigationBar];
    [self setImages];
}
- (void)setupUI {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(kAssetsBottomHeight + IPHONEX_BOTTOW_HEIGHT);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}
- (void)setNavigationBar {
    UIButton *leftBtn = [UIButton buttonWithImage:@"assets_back"];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightBtn = [UIButton buttonWithTitle:@"取消" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
#pragma mark -- 刷新视图
- (void)reloadView {
    if (self.selectPickerAssets.count == 0) {
        //没有选中数据
        self.previewBtn.hidden = YES;
        self.finishBtn.enabled = NO;
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        //有选中数据
        self.previewBtn.hidden = NO;
        self.finishBtn.enabled = YES;
        [self.finishBtn setTitle:[NSString stringWithFormat:@"完成(%ld)",self.selectPickerAssets.count] forState:UIControlStateNormal];
    }
    [self.collectionView reloadData];
}
#pragma mark -- setdata
/** 获取数据源 */
- (void)setImages {
    [MBProgressHUD showToView:self.view];
    if (self.pickerGroup) {
        [[XYPhotoPickerDatas defaultPicker]enumerateAssetsInAssetCollection:self.pickerGroup.assetCollection pickerDatasCallBack:^(id obj) {
            [self handlerWithArray:obj];
        }];
    } else {
        [[XYPhotoPickerDatas defaultPicker]enumeratePHAssetCollectionSubtype:self.subtype pickerDatasCallBack:^(id obj) {
            [self handlerWithArray:obj];
        }];
    }
}
- (void)handlerWithArray:(NSArray *)obj {
    [MBProgressHUD hideHUDForView:self.view];
    self.assetsArray = obj;
    [self.collectionView reloadData];
    if (self.assetsArray.count > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.assetsArray.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    }
}
#pragma mark -- event
/** 点击取消 */
- (void)rightNavigationBarEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 点击返回 */
- (void)leftNavigationBarEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/** 点击预览 */
- (void)previewBtnEvent:(UIButton *)sender {
    [self pushViewControllerWithPreview:YES index:0];
}
/** 点击完成 */
- (void)finishBtnBtnEvent:(UIButton *)sender {
    [MBProgressHUD showWindow];
    [[XYPhotoPickerDatas defaultPicker]getImagesFromPHAsset:self.selectPickerAssets pickerDatasCallBack:^(id obj) {
        [MBProgressHUD hideHUD];
        /** 发送通知 */
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_PICKER_TAKE_DONE object:obj];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
#pragma mark -- push
/** 跳转预览页面 */
- (void)pushViewControllerWithPreview:(BOOL)preview index:(NSInteger)index{
    XYPhotoPickerPreviewViewController *previewVC = [[XYPhotoPickerPreviewViewController alloc]init];
    if (preview) {
        previewVC.assetsArray = [NSArray arrayWithArray:self.selectPickerAssets];
    } else {
        previewVC.assetsArray = [NSArray arrayWithArray:self.assetsArray];
    }
    previewVC.selectPickerAssets = self.selectPickerAssets;
    previewVC.currentPage = index;
    previewVC.maxCount = self.maxCount;
    [self.navigationController pushViewController:previewVC animated:YES];
}
#pragma mark -- UICollectionViewDelegate
#pragma mark -- UICollectionViewDataSource
/** 行数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assetsArray.count;
}
/** 创建cell */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYPhotoPickerAssetsCollectionViewCell *cell = (XYPhotoPickerAssetsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:XYPhotoPickerAssetsCollectionViewCellID forIndexPath:indexPath];
    XYPhotoPickerAsset *assetModel = self.assetsArray[indexPath.row];
    NSInteger index = -1;
    for (int i = 0; i < self.selectPickerAssets.count; i ++) {
        XYPhotoPickerAsset *temp = self.selectPickerAssets[i];
        if ([temp.asset isEqual:assetModel.asset]) {
            index = i;
            break;
        }
    }
    WeakSelf;
    [cell reloadDataWithAssetModel:assetModel size:self.assets_cell_size indexPath:index photoPickerAssetsBlock:^(BOOL isSelected) {
        if (isSelected) {
            if (weakSelf.selectPickerAssets.count >= weakSelf.maxCount) {
                /** 超过限制个数，提示 */
                NSString *title = [NSString stringWithFormat:@"你最多只能选择%ld张照片",weakSelf.maxCount];
                [UIAlertViewTool showTitle:title message:nil titlesArr:@[@"我知道了"] alertBlock:^(NSString *mes, NSInteger index) {
                }];
            } else {
                /** 没有超过限制个数，直接添加 */
                [weakSelf.selectPickerAssets addObject:assetModel];
            }
        } else {
            /** 从添加的数组中移除 */
            [weakSelf.selectPickerAssets removeObjectAtIndex:index];
        }
        /** 刷新视图 */
        [weakSelf reloadView];
    }];
    return cell;
}
/** 选中 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self pushViewControllerWithPreview:NO index:indexPath.row];
}
#pragma mark -- setup
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.assets_cell_size, self.assets_cell_size);
        layout.sectionInset = UIEdgeInsetsMake(assets_inset_top, assets_inset_left, assets_inset_bottom, assets_inset_right);
        layout.minimumLineSpacing = assets_line_spacing;
        layout.minimumInteritemSpacing = assets_interitem_spacing;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        if (@available(iOS 11.0,*)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_collectionView registerClass:[XYPhotoPickerAssetsCollectionViewCell class] forCellWithReuseIdentifier:XYPhotoPickerAssetsCollectionViewCellID];
    }
    return _collectionView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor color_232323];
        
        UIView *topView = [[UIView alloc]init];
        [view addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.top.equalTo(view);
            make.height.mas_equalTo(kAssetsBottomHeight);
        }];
        [view addSubview:self.previewBtn];
        self.previewBtn.hidden = YES;
        [self.previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.left.equalTo(view).mas_offset(15);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        [view addSubview:self.finishBtn];
        [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(view).mas_offset(-15);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        _bottomView = view;
    }
    return _bottomView;
}
- (UIButton *)previewBtn {
    if (!_previewBtn) {
        _previewBtn = [UIButton buttonWithBGImage:@"assets_preview" title:@"预览" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
        [_previewBtn addTarget:self action:@selector(previewBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewBtn;
}
- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithBGImage:@"assets_finish" title:@"完成" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
        [_finishBtn setBackgroundImage:[UIImage imageNamed:@"assets_preview"] forState:UIControlStateDisabled];
        [_finishBtn addTarget:self action:@selector(finishBtnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}


@end
