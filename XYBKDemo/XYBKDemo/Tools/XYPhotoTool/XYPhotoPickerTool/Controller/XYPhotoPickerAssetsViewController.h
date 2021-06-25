//
//  XYPhotoPickerAssetsViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseViewController.h"
#import "XYPhotoPickerGroup.h"
#import "XYPhotoToolMacros.h"
@interface XYPhotoPickerAssetsViewController : BaseViewController

/** 最大选择数 */
@property (nonatomic, assign) NSInteger maxCount;
/** 赋值group */
@property (nonatomic ,strong) XYPhotoPickerGroup *pickerGroup;

@end
