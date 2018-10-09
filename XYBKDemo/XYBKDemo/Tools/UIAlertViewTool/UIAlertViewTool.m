//
//  UIAlertViewTool.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/8.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIAlertViewTool.h"
#import "UIAlertViewToolModel.h"
/** 按钮高度 */
const static CGFloat kUIAlertViewToolDefaultButtonHeight            = 50;
/** 线条高度 */
const static CGFloat kUIAlertViewToolDefaultButtonSpacerHeight      = 1;
/** 圆角 */
const static CGFloat kUIAlertViewToolDefaultCornerRadius            = 7;


#define ALERT_TOOL_WIDTH    [UIScreen mainScreen].bounds.size.width
#define ALERT_TOOL_HEIGHT   [UIScreen mainScreen].bounds.size.height
static UIAlertViewTool *_alertViewTool = nil;

@interface UIAlertViewTool()
/** 主视图 */
@property (nonatomic, strong) UIView *dialogView;
/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;
/** 弹窗model数组 */
@property (nonatomic, strong) NSMutableArray *toolModelArr;
/** 是否正在展示中 */
@property (nonatomic, assign) BOOL isShow;

@end

@implementation UIAlertViewTool
CGFloat  buttonHeight           = kUIAlertViewToolDefaultButtonHeight;
CGFloat  buttonSpacerHeight     = kUIAlertViewToolDefaultButtonSpacerHeight;
+ (instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _alertViewTool = [[self alloc]initWithFrame:CGRectMake(0, 0, ALERT_TOOL_WIDTH, ALERT_TOOL_HEIGHT)];
        _alertViewTool.toolModelArr = [[NSMutableArray alloc]init];
        _alertViewTool.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        //取消多次渲染
        _alertViewTool.layer.shouldRasterize = YES;
        _alertViewTool.layer.rasterizationScale = [UIScreen mainScreen].scale;
    });
    return _alertViewTool ;
}
+ (void)showTitle:(NSString *)title message:(NSString *)message alertBlock:(void (^)(NSInteger))alertBlock {
    UIAlertViewToolModel *model = [[UIAlertViewToolModel alloc]init];
    model.btnTitles = @[@"取消",@"确定"];
    model.title = title;
    model.message = message;
    model.alertViewType = UIAlertViewTypeNormal;
    model.alertBlock = alertBlock;
    [[self shareInstance]afterShowWithModel:model];
}
- (void)afterShowWithModel:(UIAlertViewToolModel *)model {
    [self.toolModelArr addObject:model];
    [self show];
}

/**
 展示弹窗
 */
- (void)show {
    if (self.toolModelArr.count == 0) {
        return;
    }
    UIAlertViewToolModel *model = self.toolModelArr[0];
    switch (model.alertViewType) {
        case UIAlertViewTypeNormal:
            [self showNormalAlertView:model];
            break;
            
        default:
            break;
    }
}
/** 显示常规弹框 */
- (void)showNormalAlertView:(UIAlertViewToolModel *)model{
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    CGFloat dialogWidth = self.containerView.frame.size.width;
    CGFloat dialogHeight = self.containerView.frame.size.height + buttonHeight + buttonSpacerHeight;
    self.dialogView.frame = CGRectMake((ALERT_TOOL_WIDTH - dialogWidth)/2, (ALERT_TOOL_HEIGHT - dialogHeight)/2, dialogWidth, dialogHeight);
}







#pragma mark -- setup
- (UIView *)dialogView {
    if (!_dialogView) {
        _dialogView = [[UIView alloc]init];
        _dialogView.layer.shouldRasterize = YES;
        _dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        CGFloat cornerRadius = kUIAlertViewToolDefaultCornerRadius;
        _dialogView.layer.cornerRadius = cornerRadius;
        _dialogView.layer.borderColor = [[UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f] CGColor];
        _dialogView.layer.borderWidth = 1;
        _dialogView.layer.shadowRadius = cornerRadius + 5;
        _dialogView.layer.shadowOpacity = 0.1f;
        _dialogView.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
        _dialogView.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    return _dialogView;
}

@end
