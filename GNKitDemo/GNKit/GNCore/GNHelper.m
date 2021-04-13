//
//  GNHelper.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNHelper.h"
@implementation GNHelper

@end

@implementation GNHelper (UIViewController)

+ (UIViewController *)gn_visibleController {
    UIViewController *vc = UIApplication.sharedApplication.keyWindow.rootViewController;
    return [vc gn_topVisiableContrller];
}

@end
