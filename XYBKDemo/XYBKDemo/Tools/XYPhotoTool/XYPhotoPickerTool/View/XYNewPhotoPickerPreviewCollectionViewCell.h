//
//  XYNewPhotoPickerPreviewCollectionViewCell.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPhotoBrowserScrollView.h"
#import "XYPhotoToolMacros.h"
NS_ASSUME_NONNULL_BEGIN

@interface XYNewPhotoPickerPreviewCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)XYPhotoBrowserScrollView *photoBrowserScrollView;

- (void)reloadDataWithModel:(id)assetModel indexPath:(NSUInteger)index photoPickerSelectedBlock:(XYNewPhotoPickerSelectedBlock)selectedBlock;

- (void)reloadSelectedWithIsSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
