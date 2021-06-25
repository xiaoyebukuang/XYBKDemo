//
//  BaseCollectionView.m
//  cwz51
//
//  Created by 陈晓 on 2020/11/26.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseCollectionView.h"

@interface BaseCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation BaseCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark -- UICollectionViewDelegate
/** 个数 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.xy_delegate xy_collectionView:collectionView numberOfItemsInSection:section];
}
/** 创建cell */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.xy_delegate xy_collectionView:collectionView cellForItemAtIndexPath:indexPath];
}
#pragma mark -- UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.xy_dataSource respondsToSelector:@selector(xy_collectionView:didSelectItemAtIndexPath:)]) {
        [self.xy_dataSource xy_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}
#pragma mark -- UICollectionViewDelegateFlowLayout
/** cell的大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.xy_delegate respondsToSelector:@selector(xy_collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.xy_delegate xy_collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    } else {
        return CGSizeMake(self.cell_width, self.cell_height);
    }
}
/** 每个分区的内边距（上左下右） */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self.xy_delegate respondsToSelector:@selector(xy_collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.xy_delegate xy_collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    } else {
        return UIEdgeInsetsMake(self.cell_insets_top, self.cell_insets_left, self.cell_insets_bottom, self.cell_insets_right);
    }
}
/** 分区内cell之间的最小行(横)间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if ([self.xy_delegate respondsToSelector:@selector(xy_collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.xy_delegate xy_collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.interitem_spacing;
    }
}
/** 分区内cell之间的最小列(纵)间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if ([self.xy_delegate respondsToSelector:@selector(xy_collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.xy_delegate xy_collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    } else {
        return self.line_spacing;
    }
}

@end
