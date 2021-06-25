//
//  BaseCollectionView.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/26.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseCollectionViewDelegate <NSObject>

@required
- (NSInteger)xy_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

- (__kindof UICollectionViewCell *)xy_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)xy_numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

- (CGSize)xy_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)xy_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)xy_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)xy_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

@end

@protocol BaseCollectionViewDataSource <NSObject>

- (void)xy_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface BaseCollectionView : UICollectionView

/** cell边距 */
@property (nonatomic, assign) CGFloat cell_insets_top;

@property (nonatomic, assign) CGFloat cell_insets_left;

@property (nonatomic, assign) CGFloat cell_insets_bottom;

@property (nonatomic, assign) CGFloat cell_insets_right;
/** cell size */
@property (nonatomic, assign) CGFloat cell_width;

@property (nonatomic, assign) CGFloat cell_height;
/** 列边距 */
@property (nonatomic, assign) CGFloat interitem_spacing;
/** 行边距 */
@property (nonatomic, assign) CGFloat line_spacing;

@property (nonatomic, weak)id<BaseCollectionViewDelegate>xy_delegate;

@property (nonatomic, weak)id<BaseCollectionViewDataSource>xy_dataSource;

@end

NS_ASSUME_NONNULL_END
