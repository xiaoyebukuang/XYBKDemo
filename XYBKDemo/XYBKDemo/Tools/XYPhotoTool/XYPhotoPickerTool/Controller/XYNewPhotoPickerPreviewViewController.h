//
//  XYNewPhotoPickerPreviewViewController.h
//  cwz51
//
//  Created by 陈晓 on 2020/11/19.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"
#import "XYPhotoToolMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYNewPhotoPickerPreviewViewController : BaseMultiViewController
/** 数据源 */
@property (nonatomic, strong) NSArray *assetsArray;
/** 选中的数据 */
@property (nonatomic, strong) NSMutableArray *selectPickerAssets;
/** 当前page */
@property (nonatomic, assign) NSInteger currentPage;
/** 最大限制数 */
@property (nonatomic, assign) NSInteger maxCount;
/** 回调 */
@property (nonatomic, copy) PhotoPickerAssetsCallBlock callBlock;
@end

NS_ASSUME_NONNULL_END
