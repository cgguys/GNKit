//
//  GNAPIClient.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/8.
//  Copyright © 2021 gunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNAPIRequest.h"
#import "GNCore.h"
#import <AFNetworking.h>

/**
 * 当前网络状态枚举
 */
typedef NS_ENUM(NSInteger, GNNetworkReachabilityStatus) {
    GNNetworkReachabilityStatusUnknown            = -1,    // 未知
    GNNetworkReachabilityStatusNotReachable       = 0,     // 无网络连接
    GNNetworkReachabilityStatusReachableViaWWAN   = 1,     // 蜂窝网络
    GNNetworkReachabilityStatusReachableViaWiFi   = 2,     // WIFI
};

NS_ASSUME_NONNULL_BEGIN

/// 当前网络变化回调
typedef void (^GNNetworkReachabilityStatusChangeBlock)(GNNetworkReachabilityStatus status);

/// 获取当前网络状态回调
typedef void (^GNFetchNetworkReachabilityStatusBlock)(GNNetworkReachabilityStatus status);

@interface GNAPIClient : NSObject

///GET POST
+ (void)executeWithRequest:(GNAPIRequest *)request finishedSuccess:(requestFinishSuccessCompletion)requestFinishSuccessCompletion finishedFailed:(requestFinishFailedCompletion)requestFinishFailedCompletion ruquestfailed:(requestFailedCompletion)requestFailedCompletion;

///上传
+ (void)execute:(GNAPIRequest *)request uploadProgress:(requestProgress)uploadProgress finishedSuccessedCompletion:(requestFinishSuccessCompletion)requestFinishSuccessCompletion finishedFailedCompletion:(requestFinishFailedCompletion)requestFinishFailedCompletion failedCompletion:(requestFailedCompletion)failedCompletion;

///下载
+ (void)execute:(GNAPIRequest *)request downloadProgress:(requestProgress)downloadProgress downloadDestination:(requestDownloadDestination)downloadDestination downloadSuccessCompletion:(requestDownloadSuccessedCompletion)downloadSuccessCompletion downloadFailedCompletion:(requestDownloadFailedCompletion)downloadFailedCompletion;


@end

@interface GNHttpSessionManager : AFHTTPSessionManager
GNSingletonH(sharedManager)
@end

@interface GNHTTPDownloadSessionManager : AFHTTPSessionManager
GNSingletonH(downloadManager)
@end

NS_ASSUME_NONNULL_END
