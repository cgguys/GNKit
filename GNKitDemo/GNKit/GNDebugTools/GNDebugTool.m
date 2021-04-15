//
//  GNDebugTool.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/12.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNDebugTool.h"
#import "GNDebugUIElementsViewController.h"
#import "GNDebugDeviceInfoViewController.h"

static NSString * const kAppAndDeviceInfo = @"APP与设备信息";
static NSString * const kSandboxBrowser = @"沙盒文件浏览器";
static NSString * const kUserDefaultsInfo = @"NSUserDefaults浏览器";
static NSString * const kUIElementDebug = @"UI调试工具";

@interface GNDebugTool ()
@property(nonatomic, strong) GNFloatingWindow *floatingWindow;
@property(nonatomic, strong) UIAlertController *alertVC;
@property(nonatomic, copy) NSMutableDictionary *dataSource;
@end

@implementation GNDebugTool

GNSingletonM(GNDebugTool, sharedInstance)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareDataSource];
        [self configDebugEntrance];
    }
    return self;
}

- (void)prepareDataSource {
    self.dataSource = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       kAppAndDeviceInfo,@"GNDebugDeviceInfoViewController",
                       kUIElementDebug,@"GNDebugUIElementsViewController",
                       nil];
}

- (void)configDebugEntrance {
    self.floatingWindow = [GNFloatingWindow showSuperManWithpaunchBcak:^{
        [self showMenuList];
    }];
    self.floatingWindow.hidden = NO;
}

- (void)showMenuList {
    if ([GNHelper gn_visibleController] == self.alertVC){
        [self.alertVC dismissViewControllerAnimated:YES completion:nil];
    }else {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        __block UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Debug工具" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:cancleAction];
        
        [self.dataSource.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class class = NSClassFromString((NSString *)obj);
            UIViewController *topRootViewController = [GNHelper gn_visibleController];
            if (![topRootViewController isKindOfClass:[class class]]) {
                    UIAlertAction *action = [UIAlertAction actionWithTitle:[self.dataSource objectForKey:obj] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        __kindof QMUICommonViewController *vc = [[class alloc] init];
                        QMUINavigationController *nav = [[QMUINavigationController alloc] initWithRootViewController:vc];
                        [[GNHelper gn_visibleController] presentViewController:nav animated:YES completion:nil];
                    }];
                [alertVC addAction:action];
            }else {
                [[GNHelper gn_visibleController] dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        [[GNHelper gn_visibleController] presentViewController:alertVC animated:YES completion:nil];
        self.alertVC = alertVC;
    }
}

@end
