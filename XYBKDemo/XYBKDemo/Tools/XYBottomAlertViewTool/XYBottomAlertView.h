//
//  XYBottomAlertView.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/17.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
typedef void(^XYBottomAlertViewBlock)(NSInteger index);

@interface XYBottomAlertView : UIView
/**
 创建底部选择框
 @param cancelTitle 取消按钮标题
 @param options 选项
 @param bottomAlertBlock 选择回调
 */
+ (void)showWithCancelTitle:(NSString *)cancelTitle
                    options:(NSArray *)options
          bottomSelectBlock:(XYBottomAlertViewBlock)bottomAlertBlock;
@end



@interface XYBottomAlertViewTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleL;

@end
