//
//  UIViewController+GNKit.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "UIViewController+GNKit.h"

@implementation UIViewController (GNKit)

- (UIViewController *)gn_topVisiableContrller{
    if (self.presentedViewController) {
       return [self.presentedViewController gn_topVisiableContrller];
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)self).topViewController gn_topVisiableContrller];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [((UITabBarController *)self).selectedViewController gn_topVisiableContrller];
    }
    
    if ([self gn_isViewLoadedAndVisible]) {
        return self;
    } else {
        return nil;
    }
}

- (BOOL)gn_isViewLoadedAndVisible
{
    return self.isViewLoaded && self.view.window;
}

@end
