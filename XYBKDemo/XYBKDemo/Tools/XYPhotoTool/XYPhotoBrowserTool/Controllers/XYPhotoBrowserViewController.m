//
//  XYPhotoBrowserViewController.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoBrowserViewController.h"
#import "XYPhotoToolMacros.h"
#import "XYPhotoBrowserCollectionViewCell.h"

static NSString * const XYPhotoBrowserCollectionViewCellID = @"XYPhotoBrowserCollectionViewCellID";

@interface XYPhotoBrowserViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, XYPhotoBrowserScrollViewDelegate>

@property (nonatomic, strong) UILabel          *pageLabel;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XYPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.collectionView];
}
#pragma mark -- XYPhotoBrowserScrollViewDelegate
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(XYPhotoBrowserScrollView *)photoScrollView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//双击
- (void) pickerPhotoScrollViewDidDoubleClick:(XYPhotoBrowserScrollView *)photoScrollView {
    
}
//长按
- (void) pickerPhotoScrollViewDidLongPressed:(XYPhotoBrowserScrollView *)photoScrollView {
    
}
#pragma mark -- UIScrollViewDelegate
/** 停止滚动时 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.frame.size.width) + 0.5);
    if (currentPage == self.currentPage) {
        return;
    }
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentPage inSection:0]]];
    self.currentPage = currentPage;
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(XYColletionViewLineSpacing, collectionView.height);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYPhotoBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYPhotoBrowserCollectionViewCellID forIndexPath:indexPath];
    cell.photoBrowserScrollView.photoScrollViewDelegate = self;
    [cell reloadViewWithPhotosArr:self.photosArr andIndexPath:indexPath.row];
    return cell;
}

#pragma mark -- setup

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = XYColletionViewLineSpacing;
        flowLayout.minimumInteritemSpacing = XYColletionViewInteritemSpacing;
        flowLayout.itemSize = self.view.size;
        //支持横向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGRect frame = self.view.bounds;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width + XYColletionViewLineSpacing,frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XYPhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:XYPhotoBrowserCollectionViewCellID];
        if (@available(iOS 11.0,*)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        if (self.photosArr.count > 0) {
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
    }
    return _collectionView;
}

@end
