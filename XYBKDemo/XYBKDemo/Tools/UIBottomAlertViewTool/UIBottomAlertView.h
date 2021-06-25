//
//  UIBottomAlertView.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

typedef void(^BottomAlertViewBlock)(NSInteger index);

@interface UIBottomAlertView : UIView

/**
 创建底部选择框
 
 @param cancelTitle 取消按钮标题
 @param options 选项
 @param alertBlock 选择回调
 */
+ (void)showWithCancelTitle:(NSString *)cancelTitle
                    options:(NSArray *)options
          bottomSelectBlock:(BottomAlertViewBlock)alertBlock;

@end

@interface UIBottomAlertViewTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleL;

@end
