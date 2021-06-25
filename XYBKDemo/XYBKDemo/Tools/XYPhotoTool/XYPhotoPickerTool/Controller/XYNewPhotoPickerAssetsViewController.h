//
//  XYNewPhotoPickerAssetsViewController.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"
#import "XYPhotoToolMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYNewPhotoPickerAssetsViewController : BaseMultiViewController

+ (void)presentPhotoPickerAssetsViewControllerWithVC:(UIViewController *)controller maxCount:(NSInteger)maxCount photoPickerAssetsCallBlock:(PhotoPickerAssetsCallBlock)callBlock;

@property (nonatomic, assign) NSInteger maxCount;

@end

NS_ASSUME_NONNULL_END
