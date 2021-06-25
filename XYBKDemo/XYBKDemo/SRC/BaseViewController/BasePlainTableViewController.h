//
//  BasePlainTableViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

@interface BasePlainTableViewController : BaseMultiViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
