//
//  XYPhotoPickerPreviewViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"

@interface XYPhotoPickerPreviewViewController : BaseViewController
/** 数据源 */
@property (nonatomic, strong) NSArray *assetsArray;
/** 选中的数据 */
@property (nonatomic, strong) NSMutableArray *selectPickerAssets;
/** 当前page */
@property (nonatomic, assign) NSInteger currentPage;
/** 最大限制数 */
@property (nonatomic, assign) NSInteger maxCount;

@end
