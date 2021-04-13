//
//  GNDebugTool.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/12.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNDebugTool.h"
#import "GNUIElementsDebugViewController.h"

static NSString * const kAppAndDeviceInfo = @"APP与设备信息";
static NSString * const kSandboxBrowser = @"沙盒文件浏览器";
static NSString * const kUserDefaultsInfo = @"NSUserDefaults";
static NSString *const kUIElementDebug = @"UI调试工具";

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
                       @"GNUIElementsDebugViewController",kUIElementDebug,
                       nil];
}

- (void)configDebugEntrance {
    GNWeakSelf
    self.floatingWindow = [GNFloatingWindow showSuperManWithpaunchBcak:^{
        GNStrongSelf
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
        __block UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Debug工具" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:cancleAction];
        
        [self.dataSource.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class class = NSClassFromString((NSString *)obj);
            UIViewController *topRootViewController = [GNHelper gn_visibleController];
            if (![topRootViewController isKindOfClass:[class class]]) {
                    UIAlertAction *action = [UIAlertAction actionWithTitle:kUIElementDebug style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        __kindof QMUICommonViewController *vc = [[class alloc] init];
                        QMUINavigationController *nav = [[QMUINavigationController alloc] initWithRootViewController:vc];
                        [[GNHelper gn_visibleController] presentViewController:nav animated:YES completion:nil];
                    }];
                [alertVC addAction:action];
            }else {
                [[GNHelper gn_visibleController] dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        [[GNHelper gn_visibleController] presentViewController:alertVC animated:YES completion:^{
            self.alertVC = alertVC;
        }];
    
    }
}

@end
