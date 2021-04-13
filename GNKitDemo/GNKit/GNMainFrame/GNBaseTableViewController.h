//
//  GNBaseTableViewController.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "QMUICommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GNBaseTableViewController : QMUICommonTableViewController

@property(nonatomic, copy) NSMutableArray *dataSource;


@end

@interface GNBaseTableViewController (GNBaseTableViewSubclassHook)

- (void)initLocalData;

@end

NS_ASSUME_NONNULL_END
