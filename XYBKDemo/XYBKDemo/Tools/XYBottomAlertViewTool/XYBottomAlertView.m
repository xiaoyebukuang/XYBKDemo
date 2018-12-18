
//
//  XYBottomAlertView.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/12/17.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYBottomAlertView.h"
static NSString * const XYBottomAlertViewTableViewCellID = @"XYBottomAlertViewTableViewCellID";


@interface XYBottomAlertView()<UITableViewDelegate, UITableViewDataSource>

/** 背景 */
@property (nonatomic, strong) UIControl *backControl;
/** 内容view */
@property (nonatomic, strong) UIView *contentView;
/** 底部按钮view */
@property (nonatomic, strong) UIView *cancelView;
/** 底部按钮 */
@property (nonatomic, strong) UIButton *cancelBtn;
/** 选项 */
@property (nonatomic, strong) UITableView *tableView;
/** 按钮标题数组 */
@property (nonatomic, strong) NSArray *options;
/** 动画时间 */
@property (nonatomic, assign) CGFloat duration;
/** 删除名称 */
@property (nonatomic, copy) NSString *cancelTitle;
/** 回调 */
@property (nonatomic, copy) XYBottomAlertViewBlock bottomAlertBlock;

@end


@implementation XYBottomAlertView

+ (void)showWithCancelTitle:(NSString *)cancelTitle
                    options:(NSArray *)options
          bottomSelectBlock:(XYBottomAlertViewBlock)bottomAlertBlock {
    XYBottomAlertView *bottomAlertView = [[XYBottomAlertView alloc]initWithCancelTitle:cancelTitle options:options bottomAlertBlock:bottomAlertBlock];
    [bottomAlertView prepareShow];
}
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle options:(NSArray *)options bottomAlertBlock:(XYBottomAlertViewBlock)bottomAlertBlock {
    self = [super init];
    if (self) {
        self.cancelTitle = cancelTitle;
        self.options = options;
        self.bottomAlertBlock = bottomAlertBlock;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.duration = 0.3;
    self.frame = MAIN_SCREEN_BOUNDS;
    [self addSubview:self.backControl];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.cancelView];
    self.backControl.frame = self.bounds;
    self.tableView.frame = CGRectMake(0, 0, self.width, 50*self.options.count);
    self.cancelView.frame = CGRectMake(0, self.tableView.height, MAIN_SCREEN_WIDTH, IPHONEX_BOTTOW_HEIGHT + 55);
    self.contentView.frame = CGRectMake(0, self.height, self.width, self.tableView.height + self.cancelView.height);
}
/** 展示view准备工作 */
- (void)prepareShow {
    [kAppDelegateWindow addSubview:self];
    self.contentView.top = MAIN_SCREEN_HEIGHT;
    [UIView animateWithDuration:self.duration animations:^{
        self.contentView.top = MAIN_SCREEN_HEIGHT - self.contentView.height;
        self.backControl.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
/** 消失 */
- (void)dismissView {
    [UIView animateWithDuration:self.duration animations:^{
        self.contentView.top = MAIN_SCREEN_HEIGHT;
        self.backControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYBottomAlertViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: XYBottomAlertViewTableViewCellID];
    cell.titleL.text = self.options[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissView];
    if (self.bottomAlertBlock) {
        self.bottomAlertBlock(indexPath.row);
    }
}
#pragma mark -- event
- (void)backControlEvent:(UIControl *)control {
    [self dismissView];
}
- (void)cancelBtnEvent:(UIButton *)sender {
    [self dismissView];
}
#pragma mark -- setup
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc]init];
        [_backControl addTarget:self action:@selector(backControlEvent:) forControlEvents:UIControlEventTouchUpInside];
        _backControl.backgroundColor = [UIColor color_000000_3];
    }
    return _backControl;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}
- (UIView *)cancelView {
    if (!_cancelView) {
        UIView *cancel = [[UIView alloc]init];
        cancel.backgroundColor = [UIColor color_FFFFFF];
        
        UIView *topBackView = [[UIView alloc]init];
        topBackView.backgroundColor = [UIColor color_F7F7F7];
        [cancel addSubview:topBackView];
        [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.equalTo(cancel);
            make.height.mas_equalTo(5);
        }];
        
        [cancel addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(cancel);
            make.top.equalTo(topBackView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        _cancelView = cancel;
    }
    return _cancelView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:[UIColor color_333333] font:SYSTEM_FONT_18];
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor color_F7F7F7];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XYBottomAlertViewTableViewCell class] forCellReuseIdentifier:XYBottomAlertViewTableViewCellID];
    }
    return _tableView;
}


@end


@interface XYBottomAlertViewTableViewCell()

@property (nonatomic, strong) UIView *lineView;

@end


@implementation XYBottomAlertViewTableViewCell
- (void)setupUI {
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(self.contentView);
        make.height.mas_offset(50);
    }];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.contentView);
        make.height.mas_offset(0.5);
    }];
}

#pragma mark -- setup
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithTextColor:[UIColor color_333333] textAlignment:NSTextAlignmentCenter font:SYSTEM_FONT_18];
    }
    return _titleL;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor color_F0F0F0];
    }
    return _lineView;
}


@end
