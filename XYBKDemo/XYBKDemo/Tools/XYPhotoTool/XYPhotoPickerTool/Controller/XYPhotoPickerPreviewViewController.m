//
//  XYPhotoPickerPreviewViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerPreviewViewController.h"
#import "XYPhotoBrowserCollectionViewCell.h"
#import "XYPhotoToolMacros.h"

static NSString * const XYPhotoBrowserCollectionViewCellID = @"XYPhotoBrowserCollectionViewCellID";
@interface XYPhotoPickerPreviewViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate>

/** 选择按钮 */
@property (nonatomic, strong) UIButton *selectBtn;
/** 完成按钮 */
@property (nonatomic, strong) UIButton *finishBtn;
/** 底部栏 */
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XYPhotoPickerPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_FFFFFF];
    [self setNavigationBar];
    [self setupUI];
    [self reloadView];
}
- (void)setNavigationBar {
    UIButton *leftBtn = [UIButton buttonWithImage:@"assets_back"];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.selectBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
- (void)setupUI {
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.mas_equalTo(kAssetsBottomHeight + IPHONEX_BOTTOW_HEIGHT);
    }];
    [self.view addSubview:self.collectionView];
}
#pragma mark -- 刷新视图
- (void)reloadView {
    PHAsset *asset = self.assetsArray[self.currentPage];
    NSUInteger index = [self.selectPickerAssets indexOfObject:asset];
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
    if (self.selectPickerAssets.count == 0) {
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.finishBtn.enabled = NO;
    } else {
        self.finishBtn.enabled = YES;
        [self.finishBtn setTitle:[NSString stringWithFormat:@"完成(%ld)",self.selectPickerAssets.count] forState:UIControlStateNormal];
    }
}
#pragma mark -- event
/** 左侧返回按钮 */
- (void)leftNavigationBarEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/** 右侧选中按钮 */
- (void)rightNavigationBarEvent:(UIButton *)sender {
    PHAsset *asset = self.assetsArray[self.currentPage];
    if (sender.selected) {
        /** 选中状态,取消选中 */
        [self.selectPickerAssets removeObject:asset];
    } else {
        /** 非选中状态，添加选中 */
        if (self.selectPickerAssets.count >= self.maxCount) {
            NSString *title = [NSString stringWithFormat:@"图片最多选取%ld张",self.maxCount];
            [MBProgressHUD showError:title];
        } else {
            [self.selectPickerAssets addObject:asset];
        }
    }
    [self reloadView];
}
/** 完成按钮 */
- (void)finishBtnBtnEvent:(UIButton *)sender {
    /** 发送通知 */
    [MBProgressHUD showWindow];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[XYPhotoPickerDatas defaultPicker]getImagesFromPHAsset:self.selectPickerAssets callBack:^(NSArray<UIImage *> *images) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_PICKER_TAKE_DONE object:images];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    });
}
#pragma mark -- UIScrollViewDelegate
/** 停止滚动时 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.frame.size.width) + 0.5);
    if (currentPage == self.currentPage) {
        return;
    }
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentPage inSection:0]]];
    self.currentPage = currentPage;
    [self reloadView];
}
#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
/** 行数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assetsArray.count;
}
/** cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYPhotoBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYPhotoBrowserCollectionViewCellID forIndexPath:indexPath];
    [cell reloadViewWithPhotosArr:self.assetsArray andIndexPath:indexPath.row];
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
        [_collectionView registerClass:[XYPhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:XYPhotoBrowserCollectionViewCellID];
        if (@available(iOS 11.0,*)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        if (self.assetsArray.count > 0) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
    }
    return _collectionView;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithBGImage:@"assets_normal" selectBGImage:(NSString *)@"assets_selected" title:@"" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
        _selectBtn.frame = CGRectMake(0, 0, 32, 32);
        [_selectBtn addTarget:self action:@selector(rightNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
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
- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithBGImage:@"assets_finish" title:@"完成" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
        [_finishBtn setBackgroundImage:[UIImage imageNamed:@"assets_preview"] forState:UIControlStateDisabled];
        [_finishBtn addTarget:self action:@selector(finishBtnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}
@end
