//
//  XYNewPhotoPickerAssetsViewController.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "XYNewPhotoPickerAssetsViewController.h"
#import "XYNewPhotoPickerPreviewViewController.h"
#import "XYNewPhotoPickerAssetsCollectionViewCell.h"
#import "CustomNavigationController.h"
/** 内边距 */
static const CGFloat assets_inset_top = 12.0f;
static const CGFloat assets_inset_left = 12.0f;
static const CGFloat assets_inset_bottom = 12.0f;
static const CGFloat assets_inset_right = 12.0f;
/** 列间距 */
static const CGFloat assets_interitem_spacing = 6.0f;
/** 行间距 */
static const CGFloat assets_line_spacing = 6.0f;

static const NSInteger assets_number = 3;

static NSString * const XYNewPhotoPickerAssetsCollectionViewCellID = @"XYNewPhotoPickerAssetsCollectionViewCellID";

@interface XYNewPhotoPickerAssetsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign) CGFloat assets_cell_width;

@property (nonatomic, assign) CGFloat assets_cell_height;


/** 底部view */
@property (nonatomic, strong) UIView *bottomView;
/** 预览按钮 */
@property (nonatomic, strong) UIButton *previewBtn;
/** 完成按钮 */
@property (nonatomic, strong) UIButton *finishBtn;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *assetsArray;
/** 选中的数据 */
@property (nonatomic, strong) NSMutableArray *selectPickerAssets;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) PhotoPickerAssetsCallBlock callBlock;

@end

@implementation XYNewPhotoPickerAssetsViewController
+ (void)presentPhotoPickerAssetsViewControllerWithVC:(UIViewController *)controller maxCount:(NSInteger)maxCount photoPickerAssetsCallBlock:(PhotoPickerAssetsCallBlock)callBlock {
    XYNewPhotoPickerAssetsViewController *vc = [[XYNewPhotoPickerAssetsViewController alloc]init];
    vc.maxCount = maxCount;
    vc.callBlock = callBlock;
    CustomNavigationController *nv = [[CustomNavigationController alloc]initWithRootViewController:vc];
    [controller presentViewController:nv animated:YES completion:nil];
}
- (void)leftNavigationBarEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightNavigationBarEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadView];
    [self.collectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"相册";
    [self setRightNavigationBarWithImageStr:@"alert_bottom_close"];
    self.view.backgroundColor = [UIColor color_main];
    self.assets_cell_width = (MAIN_SCREEN_WIDTH - assets_inset_left - assets_inset_right - assets_interitem_spacing*(assets_number - 1))/assets_number - 0.5;
    self.assets_cell_height = self.assets_cell_width;
    self.selectPickerAssets = [NSMutableArray array];
    self.assetsArray = [NSMutableArray array];
    [self setupUI];
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
- (void)reloadView {
    if (self.selectPickerAssets.count == 0) {
        self.previewBtn.alpha = 0.3;
        self.previewBtn.enabled = NO;
        self.finishBtn.alpha = 0.3;
        self.finishBtn.enabled = NO;
    } else {
        self.previewBtn.alpha = 1;
        self.previewBtn.enabled = YES;
        self.finishBtn.alpha = 1;
        self.finishBtn.enabled = YES;
    }
}
#pragma mark -- event
/** 点击预览 */
- (void)previewBtnEvent:(UIButton *)sender {
    [self pushViewControllerWithPreview:YES index:0];
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
#pragma mark -- push
/** 跳转预览页面 */
- (void)pushViewControllerWithPreview:(BOOL)preview index:(NSInteger)index{
    XYNewPhotoPickerPreviewViewController *previewVC = [[XYNewPhotoPickerPreviewViewController alloc]init];
    if (preview) {
        previewVC.assetsArray = [NSArray arrayWithArray:self.selectPickerAssets];
    } else {
        previewVC.assetsArray = [NSArray arrayWithArray:self.assetsArray];
    }
    previewVC.selectPickerAssets = self.selectPickerAssets;
    previewVC.currentPage = index;
    previewVC.maxCount = self.maxCount;
    previewVC.callBlock = self.callBlock;
    [self.navigationController pushViewController:previewVC animated:YES];
}
#pragma mark -- setdata
/** 获取数据源 */
- (void)setImages {
    [MBProgressHUD showToView:self.view];
    [[XYPhotoPickerDatas defaultPicker]loadAlbumGroupCompletionHandler:^(NSArray<XYPhotoPickerGroup *> *group) {
        for (XYPhotoPickerGroup *pickerGroup in group) {
            if (pickerGroup.assetSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                [[XYPhotoPickerDatas defaultPicker]fetchAssetsInAssetCollection:pickerGroup.assetCollection callBack:^(NSArray<PHAsset *> *assets) {
                    [self.assetsArray removeAllObjects];
                    [self.assetsArray addObjectsFromArray:[[assets reverseObjectEnumerator] allObjects]];
                    [self.collectionView reloadData];
                    [MBProgressHUD hideHUDForView:self.view];
                }];
                break;
            }
        }
    }];
}
//照片选择回调
#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (portraitImg) {
            [[XYPhotoPickerDatas defaultPicker]loadImageFinished:portraitImg callBack:^(BOOL success, NSError * _Nullable error) {
                
            }];
            [self.assetsArray insertObject:portraitImg atIndex:0];
            [self.selectPickerAssets addObject:portraitImg];
            [self reloadView];
            [self.collectionView reloadData];
        }
    }];
}
#pragma mark -- UICollectionViewDelegate
#pragma mark -- UICollectionViewDataSource
/** 行数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.assetsArray.count > 0) {
        return self.assetsArray.count + 1;
    }
    return 0;
}
/** 创建cell */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYNewPhotoPickerAssetsCollectionViewCell *cell = (XYNewPhotoPickerAssetsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:XYNewPhotoPickerAssetsCollectionViewCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell reloadCamera];
    } else {
        id assetModel = self.assetsArray[indexPath.row - 1];
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
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                    [weakSelf reloadView];
                }
            } else {
                /** 从添加的数组中移除 */
                [weakSelf.selectPickerAssets removeObject:assetModel];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                [weakSelf reloadView];
            }
        }];
    }
    return cell;
}
/** 选中 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.selectPickerAssets.count >= self.maxCount) {
            /** 超过限制个数，提示 */
            NSString *title = [NSString stringWithFormat:@"图片最多选取%d张",(int)self.maxCount];
            [MBProgressHUD showError:title];
        } else {
            [UIJudgeTool checkCameraAuthorizationStatus:^(BOOL handler) {
                if (handler) {
                    //有权限
                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                    controller.delegate = self;
                    [self presentViewController:controller animated:YES completion:nil];
                }
            }];
        }
    } else {
        [self pushViewControllerWithPreview:NO index:indexPath.row - 1];
    }
}
#pragma mark -- setup
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.assets_cell_width, self.assets_cell_height);
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
        [_collectionView registerClass:[XYNewPhotoPickerAssetsCollectionViewCell class] forCellWithReuseIdentifier:XYNewPhotoPickerAssetsCollectionViewCellID];
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
        [view addSubview:self.previewBtn];
        [self.previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.left.equalTo(view).mas_offset(12);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        [view addSubview:self.finishBtn];
        [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.height.equalTo(self.previewBtn);
            make.right.equalTo(view).mas_offset(-12);
        }];
        _bottomView = view;
    }
    return _bottomView;
}
- (UIButton *)previewBtn {
    if (!_previewBtn) {
        _previewBtn = [UIButton buttonWithTitle:@"预览" titleColor:[UIColor color_222222] font:SYSTEM_FONT_15];
        _previewBtn.backgroundColor = [UIColor color_EEEEEE];
        _previewBtn.alpha = 0.3;
        _previewBtn.layer.cornerRadius = 15;
        _previewBtn.layer.masksToBounds = YES;
        _previewBtn.enabled = NO;
        [_previewBtn addTarget:self action:@selector(previewBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewBtn;
}
- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithTitle:@"完成" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_15];
        _finishBtn.backgroundColor = [UIColor color_FF712C];
        _finishBtn.layer.cornerRadius = 15;
        _finishBtn.layer.masksToBounds = YES;
        _finishBtn.alpha = 0.3;
        _finishBtn.enabled = NO;
        [_finishBtn addTarget:self action:@selector(finishBtnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

@end
