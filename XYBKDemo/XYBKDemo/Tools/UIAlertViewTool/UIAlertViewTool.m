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
/** 弹窗宽度 */
const static CGFloat kUIAlertViewToolDefaultWidth                   = 300;

#define ALERT_TOOL_WIDTH    [UIScreen mainScreen].bounds.size.width
#define ALERT_TOOL_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define ALERT_TOOL_CLOSE_BTN_TAG    1234

static UIAlertViewTool *_alertViewTool = nil;

@interface UIAlertViewTool()
/** 主视图 */
@property (nonatomic, strong) UIView *dialogView;
/** 内容视图 */
@property (nonatomic, strong) UIView *containerView;
/** 弹窗model数组 */
@property (nonatomic, strong) NSMutableArray *toolModelArr;
/** btnView */
@property (nonatomic, strong) UIView *btnView;
/** 是否正在展示中 */
@property (nonatomic, assign) BOOL isShow;
/** 当前的model */
@property (nonatomic, strong) UIAlertViewToolModel *currectModel;

/** 常用标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 常用副标题 */
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation UIAlertViewTool
CGFloat  buttonHeight           = kUIAlertViewToolDefaultButtonHeight;
CGFloat  buttonSpacerHeight     = kUIAlertViewToolDefaultButtonSpacerHeight;
CGFloat  toolWidth              = kUIAlertViewToolDefaultWidth;
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
+ (void)showTitle:(NSString *)title message:(NSString *)message titlesArr:(NSArray *)titlesArr alertBlock:(void(^)(NSInteger index))alertBlock {
    UIAlertViewToolModel *model = [[UIAlertViewToolModel alloc]init];
    model.btnTitles = titlesArr;
    model.title = title;
    model.message = message;
    model.alertViewType = UIAlertViewTypeNormal;
    model.alertBlock = alertBlock;
    [[self shareInstance]afterShowWithModel:model];
}
+ (void)showView:(UIView *)view titlesArr:(NSArray *)titlesArr alertBlock:(void(^)(NSInteger index))alertBlock {
    UIAlertViewToolModel *model = [[UIAlertViewToolModel alloc]init];
    model.customView = view;
    model.btnTitles = titlesArr;
    model.alertViewType = UIAlertViewTypeCustom;
    model.alertBlock = alertBlock;
    [[self shareInstance]afterShowWithModel:model];
}
- (void)afterShowWithModel:(UIAlertViewToolModel *)model {
    [self.toolModelArr insertObject:model atIndex:0];
    [self show];
}
//TODO: 展示
/** 展示弹窗 */
- (void)show {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.toolModelArr.count == 0) {
        return;
    }
    if (self.isShow) {
        [self dismissWithRemove];
        return;
    }
    self.isShow = YES;
    self.currectModel = self.toolModelArr[0];
    switch (self.currectModel.alertViewType) {
        case UIAlertViewTypeNormal:
            [self showNormalAlertView];
            break;
        case UIAlertViewTypeCustom:
            [self showCustomAlertView];
            break;
        default:
            break;
    }
}
/** 显示自定义弹窗 */
- (void)showCustomAlertView {
    self.containerView = self.currectModel.customView;
    //动画
    [self showAnimation];
}
/** 显示常规弹框 */
- (void)showNormalAlertView {
    self.containerView = [[UIView alloc]init];
    //赋值
    self.messageLabel.text = self.currectModel.message;
    self.titleLabel.text = self.currectModel.title;
    //设置frame
    CGFloat space = 20.0f;
    self.titleLabel.frame = CGRectMake(space, space, toolWidth - space*2, 20);
    CGFloat message_height = [self getHeightWithWidth:CGRectGetWidth(self.titleLabel.frame) str:self.messageLabel.text font:self.messageLabel.font];
    if (message_height <= 60) {
        message_height = 60;
    }
    self.messageLabel.frame = CGRectMake(space, space + CGRectGetHeight(self.titleLabel.frame) + space, CGRectGetWidth(self.titleLabel.frame), message_height);
    self.containerView.frame = CGRectMake(0, 0, toolWidth, space + CGRectGetHeight(self.titleLabel.frame) + space + message_height + space);
    //添加视图
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.messageLabel];
    //动画
    [self showAnimation];
}
/** 开始动画 */
- (void)showAnimation {
    CGFloat btn_height = buttonHeight + buttonSpacerHeight;
    CGFloat dialogWidth = self.containerView.frame.size.width;
    CGFloat dialogHeight = self.containerView.frame.size.height + btn_height;
    self.dialogView.frame = CGRectMake((ALERT_TOOL_WIDTH - dialogWidth)/2, (ALERT_TOOL_HEIGHT - dialogHeight)/2, dialogWidth, dialogHeight);
    self.btnView.frame = CGRectMake(0, CGRectGetHeight(self.dialogView.frame) - btn_height, CGRectGetWidth(self.dialogView.frame), btn_height);
    //添加按钮
    [self addButtons];
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    [self addSubview:self.dialogView];
    [self.dialogView addSubview:self.containerView];
    [self.dialogView addSubview:self.btnView];
    //开始动画
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3f, 1.3f);
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        self.dialogView.layer.opacity = 1.0f;
        self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    } completion:^(BOOL finished) {
        
    }];
}
//获取高度
- (CGFloat)getHeightWithWidth:(CGFloat)width str:(NSString *)str font:(UIFont *)font {
    return [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : font} context:nil].size.height;
}
/** 添加按钮 */
- (void)addButtons {
    for (UIView *subView in self.btnView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.btnView.frame), buttonSpacerHeight)];
    lineV.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
    [self.btnView addSubview:lineV];
    
    CGFloat buttonWidth = CGRectGetWidth(self.btnView.frame)/self.currectModel.btnTitles.count;
    for (int i=0; i < self.currectModel.btnTitles.count; i++) {
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(i * buttonWidth, buttonSpacerHeight, buttonWidth, buttonHeight)];
        [closeButton addTarget:self action:@selector(closeButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:ALERT_TOOL_CLOSE_BTN_TAG + i];
        [closeButton setTitle:self.currectModel.btnTitles[i] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.btnView addSubview:closeButton];
    }
}
//TODO: 消失
- (void)dismissWithRemove{
    self.isShow = NO;
    for (UIView *v in [self subviews]) {
        [v removeFromSuperview];
    }
    for (UIView *v in [self.dialogView subviews]) {
        [v removeFromSuperview];
    }
    [self.dialogView removeFromSuperview];
    [self removeFromSuperview];
    self.currectModel = nil;
    [self show];
}
- (void)dismissWithIndex:(NSInteger)index{
    self.dialogView.layer.opacity = 1.0f;
    self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        self.dialogView.layer.opacity = 0.0f;
        self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6f, 0.6f);
    } completion:^(BOOL finished) {
        self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        self.currectModel.alertBlock(index);
        [self.toolModelArr removeObject:self.currectModel];
        [self dismissWithRemove];
    }];
}
#pragma mark -- event
- (void)closeButtonEvent:(UIButton *)sender {
    [self dismissWithIndex:sender.tag - ALERT_TOOL_CLOSE_BTN_TAG];
}

#pragma mark -- setup
- (UIView *)dialogView {
    if (!_dialogView) {
        _dialogView = [[UIView alloc]init];
        _dialogView.backgroundColor = [UIColor whiteColor];
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
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}
- (UIView *)btnView {
    if (!_btnView) {
        _btnView = [[UIView alloc]init];
    }
    return _btnView;
}

@end
