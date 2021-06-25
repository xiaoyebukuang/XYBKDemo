//
//  XYPhotoPickerAssetsCollectionViewCell.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPhotoPickerGroup.h"

typedef void(^XYPhotoPickerAssetsBlock)(BOOL isSelected);

@interface XYPhotoPickerAssetsCollectionViewCell : UICollectionViewCell

- (void)reloadDataWithPHAssets:(PHAsset *)asset indexPath:(NSUInteger)index photoPickerAssetsBlock:(XYPhotoPickerAssetsBlock)assetsBlock;


@end
