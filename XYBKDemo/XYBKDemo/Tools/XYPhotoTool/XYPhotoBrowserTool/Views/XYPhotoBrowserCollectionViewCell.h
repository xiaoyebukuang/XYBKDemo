//
//  XYPhotoBrowserCollectionViewCell.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/15.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPhotoBrowserScrollView.h"

@interface XYPhotoBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)XYPhotoBrowserScrollView *photoBrowserScrollView;

- (void)reloadViewWithPhotosArr:(NSArray *)photosArr andIndexPath:(NSInteger)row;
- (void)reloadViewWithPhotosArr:(NSArray *)photosArr andIndexPath:(NSInteger)row placeholderImage:(UIImage *)placeholderImage;
@end
