//
//  UIBottomAlertView.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/30.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIBottomAlertView.h"

static const CGFloat cell_height = 56;
static const CGFloat bottom_space = 8;

static NSString * const UIBottomAlertViewTableViewCellID = @"UIBottomAlertViewTableViewCellID";

@interface UIBottomAlertView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *contentView;
//backView
@property (nonatomic, strong) UIControl *backControl;
/** 底部按钮view */
@property (nonatomic, strong) UIView *cancelView;
/** 底部按钮 */
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *writeView;

@property (nonatomic, assign) CGFloat duration;

/** 删除名称 */
@property (nonatomic, copy) NSString *cancelTitle;
/** 按钮标题数组 */
@property (nonatomic, strong) NSArray *options;
/** 回调 */
@property (nonatomic, copy) BottomAlertViewBlock alertBlock;

@end

@implementation UIBottomAlertView

+ (void)showWithCancelTitle:(NSString *)cancelTitle
                    options:(NSArray *)options
          bottomSelectBlock:(BottomAlertViewBlock)alertBlock {
    UIBottomAlertView *bottomAlertView = [[UIBottomAlertView alloc]initWithCancelTitle:cancelTitle options:options bottomSelectBlock:alertBlock];
    [bottomAlertView prepareShow];
}
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle options:(NSArray *)options bottomSelectBlock:(BottomAlertViewBlock)alertBlock {
    self = [super init];
    if (self) {
        self.cancelTitle = cancelTitle;
        self.options = options;
        self.alertBlock = alertBlock;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.duration = ANIMATION_DURATION;
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    [self addSubview:self.backControl];
    self.backControl.frame = self.bounds;
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.writeView];
    self.writeView.frame = CGRectMake(0, cell_height, MAIN_SCREEN_WIDTH, cell_height*(self.options.count - 1));
    [self.contentView addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, cell_height*self.options.count);
    self.cancelView.frame = CGRectMake(0, self.tableView.height, MAIN_SCREEN_WIDTH, IPHONEX_BOTTOW_HEIGHT + cell_height + bottom_space);
    [self.contentView addSubview:self.cancelView];
    self.contentView.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, self.tableView.height + self.cancelView.height);
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
#pragma mark -- event
- (void)backControlEvent:(UIControl *)control {
    [self dismissView];
}
- (void)cancelBtnEvent:(UIButton *)sender {
    [self dismissView];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIBottomAlertViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: UIBottomAlertViewTableViewCellID];
    cell.titleL.text = self.options[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissView];
    if (self.alertBlock) {
        self.alertBlock(indexPath.row);
    }
}
#pragma mark -- setup
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc]init];
        [_backControl addTarget:self action:@selector(backControlEvent:) forControlEvents:UIControlEventTouchUpInside];
        _backControl.backgroundColor = [UIColor color_000000_5];
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
        topBackView.backgroundColor = [UIColor color_main];
        [cancel addSubview:topBackView];
        [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.equalTo(cancel);
            make.height.mas_equalTo(bottom_space);
        }];
        
        [cancel addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(cancel);
            make.top.equalTo(topBackView.mas_bottom);
            make.height.mas_equalTo(cell_height);
        }];
        _cancelView = cancel;
    }
    return _cancelView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:[UIColor color_222222] font:SYSTEM_FONT_17];
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIView *)writeView {
    if (!_writeView) {
        _writeView = [[UIView alloc]init];
        _writeView.backgroundColor = [UIColor color_FFFFFF];
    }
    return _writeView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 10;
        _tableView.backgroundColor = [UIColor color_FFFFFF];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = cell_height;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UIBottomAlertViewTableViewCell class] forCellReuseIdentifier:UIBottomAlertViewTableViewCellID];
    }
    return _tableView;
}


@end


@interface UIBottomAlertViewTableViewCell()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation UIBottomAlertViewTableViewCell
- (void)setupUI {
    [self.contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(self.contentView);
        make.height.mas_offset(cell_height);
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
        _titleL = [[UILabel alloc]initWithTextColor:[UIColor color_222222] font:SYSTEM_FONT_16];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor color_F7F7F7];
    }
    return _lineView;
}


@end
