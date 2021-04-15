//
//  GNUIElementsDebugViewController.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNDebugUIElementsViewController.h"

static NSString * const kUIElement = @"UI元素信息";
static NSString * const k3DChecker = @"3D UI界面调试";
static NSString * const kLookInExport = @"导出 Lookin 文件";

@interface GNDebugUIElementsViewController ()

@end

@implementation GNDebugUIElementsViewController

- (void)initTableView {
    [super initTableView];
    QMUIStaticTableViewCellDataSource *dataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:@[@[
                                                                                                                              [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:0 image:nil text:kUIElement detailText:nil didSelectTarget:self didSelectAction:@selector(handleLookin2DChecker) accessoryType:QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator],
        [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:1 image:nil text:k3DChecker detailText:nil didSelectTarget:self didSelectAction:@selector(handleLookin3DChecker) accessoryType:QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator],
        [QMUIStaticTableViewCellData staticTableViewCellDataWithIdentifier:2 image:nil text:kLookInExport detailText:nil didSelectTarget:self didSelectAction:@selector(handleLookInExport) accessoryType:QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator]
    ]]];
    self.tableView.qmui_staticCellDataSource = dataSource;
}

- (void)handleLookin2DChecker {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
        });
    }];
}

- (void)handleLookin3DChecker {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
        });
    }];
}

- (void)handleLookInExport {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_Export" object:nil];
        });
    }];
}


@end
