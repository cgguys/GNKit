//
//  GNHelper.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNCore.h"

NS_ASSUME_NONNULL_BEGIN

@interface GNHelper : NSObject

@end

@interface GNHelper (UIViewController)

+ (UIViewController *)gn_visibleController;

@end

NS_ASSUME_NONNULL_END
