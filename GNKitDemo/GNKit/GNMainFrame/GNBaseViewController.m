//
//  GNBaseViewController.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNBaseViewController.h"

@interface GNBaseViewController ()

@end

@implementation GNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorWhite;
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    if (self.presentingViewController) {
        [UIBarButtonItem qmui_closeItemWithTarget:self action:@selector(dismiss)];
    }
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
