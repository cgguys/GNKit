//
//  GNBaseTableViewController.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNBaseTableViewController.h"

@interface GNBaseTableViewController ()

@end

@implementation GNBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initLocalData];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    if (self.presentingViewController) {
        UIBarButtonItem *dismissItem = [UIBarButtonItem qmui_closeItemWithTarget:self action:@selector(dismiss)];
        self.navigationItem.leftBarButtonItem = dismissItem;
    }
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSMutableArray *)dataSource {
    if (_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end

@implementation GNBaseTableViewController (GNBaseTableViewSubclassHook)

- (void)initLocalData {
    ///子类重写
}

@end
