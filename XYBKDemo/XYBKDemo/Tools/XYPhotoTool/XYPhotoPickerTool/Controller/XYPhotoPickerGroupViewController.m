//
//  XYPhotoPickerGroupViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/31.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPhotoPickerGroupViewController.h"
#import "XYPhotoToolMacros.h"
#import "XYPhotoPickerGroupTableViewCell.h"
#import "XYPhotoPickerAssetsViewController.h"
#import <Photos/Photos.h>
static NSString * const XYPhotoPickerGroupTableViewCellID = @"XYPhotoPickerGroupTableViewCellID";

@interface XYPhotoPickerGroupViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSArray *dataGroups;
@end

@implementation XYPhotoPickerGroupViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        //默认为9
        self.maxCount = 9;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_FFFFFF];
    self.navigationItem.title = @"选择相册";
    [self setNavigation];
    [self setupUI];
    [self setImages];
}
- (void)setNavigation {
    //右侧按钮
    UIButton *rightBtn = [UIButton buttonWithTitle:@"取消" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn addTarget:self action:@selector(rightNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark -- setdata
- (void)setImages {
    [[XYPhotoPickerDatas defaultPicker]loadAlbumGroupCompletionHandler:^(NSArray<XYPhotoPickerGroup *> *group) {
        self.dataGroups = group;
        [self gotoHistoryGroup];
        [self.tableView reloadData];
    }];
}
- (void)gotoHistoryGroup {
    XYPhotoPickerGroup *gp = nil;
    for (XYPhotoPickerGroup *group in self.dataGroups) {
        switch (self.status) {
            case PickerViewShowStatusCameraRoll:
            {
                if (group.assetSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                    gp = group;
                }
            }
                break;
            default:
                break;
        }
    }
    if (gp) {
        [self setupAssetsVCWithGroup:gp animation:NO];
    }
}
- (void)setupAssetsVCWithGroup:(XYPhotoPickerGroup *)pickerGroup animation:(BOOL)animated{
    XYPhotoPickerAssetsViewController* assetsVC = [[XYPhotoPickerAssetsViewController alloc]init];
    assetsVC.pickerGroup = pickerGroup;
    assetsVC.maxCount = self.maxCount;
    [self.navigationController pushViewController:assetsVC animated:animated];
}
#pragma mark -- event
- (void)rightNavigationBarEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataGroups.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYPhotoPickerGroupTableViewCell *cell = (XYPhotoPickerGroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier: XYPhotoPickerGroupTableViewCellID];
    cell.pickerGroup = self.dataGroups[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setupAssetsVCWithGroup:self.dataGroups[indexPath.row] animation:YES];
}
#pragma mark -- setup
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 130;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XYPhotoPickerGroupTableViewCell class] forCellReuseIdentifier:XYPhotoPickerGroupTableViewCellID];
        if (@available(iOS 11.0,*)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

@end
