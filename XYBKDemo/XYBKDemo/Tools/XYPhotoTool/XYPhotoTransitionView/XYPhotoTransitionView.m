//
//  XYPhotoTransitionView.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/1.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoTransitionView.h"
#import "XYPhotoToolMacros.h"
#import "XYPhotoBrowserCollectionViewCell.h"

static NSString * const XYPhotoBrowserCollectionViewCellID = @"XYPhotoBrowserCollectionViewCellID";

static const NSTimeInterval rootViewAnimations = 0.2f;


/**
 具有过渡动画，在当前视图中过渡动画显示图片浏览器
 */
@interface XYPhotoTransitionView()<UICollectionViewDelegate, UICollectionViewDataSource, XYPhotoBrowserScrollViewDelegate>

@property (nonatomic, strong) UILabel          *pageLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) UIViewContentMode contentMode;

@end
@implementation XYPhotoTransitionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.collectionView];
    [self addSubview:self.pageLabel];
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-30);
    }];
    
    if (@available(iOS 11.0,*)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
}
/** 显示动画 */
- (void)showPhotoBrowerViewWithCurrentPage:(NSInteger)currentPage image:(UIImage *)image contentMode:(UIViewContentMode)contentMode photosArr:(NSArray *)photosArr {
    self.contentMode = contentMode;
    self.photosArr = photosArr;
    self.currentPage = currentPage;
    self.pageLabel.text =  [NSString stringWithFormat:@"%ld/%ld",currentPage + 1, self.photosArr.count];
    UIWindow *window = kKeyWindow;
    if ([self.delegate respondsToSelector:@selector(getFrameWithCurrentPage:sourceView:)]) {
        CGRect frame = [self.delegate getFrameWithCurrentPage:currentPage sourceView:self];
        //黑色背景
        UIView *backView = [[UIView alloc]initWithFrame:window.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0;
        [window addSubview:backView];
        //过渡动画
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.contentMode = contentMode;
        imageView.image = image;
        imageView.clipsToBounds = YES;
        [window addSubview:imageView];
        CGRect imageV_frame = [self getImageViewSize:image];
        [UIView animateWithDuration:rootViewAnimations animations:^{
            imageView.frame = imageV_frame;
            backView.alpha = 1;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            [backView removeFromSuperview];
            [window addSubview:self];
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }];
    } else {
        [window addSubview:self];
    }
}
- (CGRect)getImageViewSize:(UIImage *)img {
    //设置缩放
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = img.size;
    //宽度缩放比例
    CGFloat xScale = boundsSize.width/imageSize.width;
    //高度缩放比例
    CGFloat yScale = boundsSize.height/imageSize.height;
    
    CGFloat imageV_width;
    CGFloat imageV_height;
    CGRect frame;
    if (xScale < yScale) {
        //高度缩放不满屏，宽度缩放满屏
        imageV_width = boundsSize.width;
        imageV_height = xScale*imageSize.height;
        frame = CGRectMake(0, (boundsSize.height - imageV_height)/2, imageV_width, imageV_height);
    }else{
        //高度缩放超屏，宽度缩放满屏
        imageV_height = boundsSize.height;
        imageV_width = yScale*imageSize.width;
        frame = CGRectMake((boundsSize.width - imageV_width)/2, 0, imageV_width, imageV_height);
    }
    return frame;
}
/** 消失动画 */
- (void) dismiss{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dismissWithCurrentPage:)]) {
        [self.delegate dismissWithCurrentPage:self.currentPage];
    }
    if ([self.delegate respondsToSelector:@selector(getFrameWithCurrentPage:sourceView:)]) {
        UIWindow *window = kKeyWindow;
        //黑色背景
        CGRect sourceFrame = [self.delegate getFrameWithCurrentPage:self.currentPage sourceView:self];
        UIView *backView = [[UIView alloc]initWithFrame:window.bounds];
        backView.backgroundColor = [UIColor blackColor];
        [window addSubview:backView];
        //过渡动画
        XYPhotoBrowserCollectionViewCell *cell = (XYPhotoBrowserCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0]];
        UIImageView *sourceImageV = (UIImageView *)cell.photoBrowserScrollView.photoBrowserImageView;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:sourceImageV.frame];
        imageView.contentMode = self.contentMode;
        imageView.clipsToBounds = YES;
        imageView.image = sourceImageV.image;
        [window addSubview:imageView];
        [UIView animateWithDuration:rootViewAnimations animations:^{
            imageView.frame = sourceFrame;
            backView.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            [backView removeFromSuperview];
        }];
    }
}
#pragma mark -- XYPhotoBrowserScrollViewDelegate
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(XYPhotoBrowserScrollView *)photoScrollView {
    [self dismiss];
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
    self.pageLabel.text =  [NSString stringWithFormat:@"%ld/%ld",self.currentPage + 1, self.photosArr.count];
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = XYColletionViewLineSpacing;
        flowLayout.minimumInteritemSpacing = XYColletionViewInteritemSpacing;
        flowLayout.itemSize = self.size;
        //支持横向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGRect frame = self.bounds;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width + XYColletionViewLineSpacing,frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XYPhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:XYPhotoBrowserCollectionViewCellID];
    }
    return _collectionView;
}
- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc]initWithTextColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_24];
    }
    return _pageLabel;
}

@end
