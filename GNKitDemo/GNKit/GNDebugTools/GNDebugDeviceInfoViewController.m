//
//  GNDebugDeviceInfoViewController.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/15.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNDebugDeviceInfoViewController.h"

@interface GNDebugDeviceInfoViewController ()

@end

@implementation GNDebugDeviceInfoViewController

- (void)initTableView {
    [super initTableView];
    QMUIStaticTableViewCellDataSource *dataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:@[@[({
        QMUIStaticTableViewCellData *data = [self configCellDataWithText:@"手机型号" detailText:[QMUIHelper deviceName]];
        data;
    }),({
        QMUIStaticTableViewCellData *data = [self configCellDataWithText:@"系统版本" detailText:[QMUIHelper deviceModel]];
        data;
    })
    ],@[({
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
        QMUIStaticTableViewCellData *data = [self configCellDataWithText:@"App名称" detailText:appName];
        data;
    }),({
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        QMUIStaticTableViewCellData *data = [self configCellDataWithText:@"App版本号" detailText:appVersion];
        data;
    }),({
        NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        QMUIStaticTableViewCellData *data = [self configCellDataWithText:@"BundleId" detailText:bundleId];
        data;
    })
    ],@[
    
    ]]];
    
    self.tableView.qmui_staticCellDataSource = dataSource;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"设备信息";
            break;
            case 1:
                return @"App信息";
                break;
            case 2:
                return @"App权限";
                break;
        default:
            return @"";
            break;
    }
}


- (QMUIStaticTableViewCellData *)configCellDataWithText:(NSString *)text detailText:(NSString *)detailText {
    QMUIStaticTableViewCellData *data = [[QMUIStaticTableViewCellData alloc] init];
    data.accessoryType = UITableViewCellAccessoryNone;
    data.style = UITableViewCellStyleValue1;
    data.text = text;
    data.detailText = detailText;
    return data;
}


@end
