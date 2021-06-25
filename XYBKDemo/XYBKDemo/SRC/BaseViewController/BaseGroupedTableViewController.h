//
//  BaseGroupedTableViewController.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/27.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

@interface BaseGroupedTableViewController : BaseMultiViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
