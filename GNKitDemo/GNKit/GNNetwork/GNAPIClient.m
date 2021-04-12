//
//  GNAPIClient.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/8.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNAPIClient.h"

@implementation GNAPIClient

+ (void)executeWithRequest:(GNAPIRequest *)request finishedSuccess:(requestFinishSuccessCompletion)requestFinishSuccessCompletion finishedFailed:(requestFinishFailedCompletion)requestFinishFailedCompletion ruquestfailed:(requestFailedCompletion)requestFailedCompletion {
    switch (request.accessType) {
        case GNAPIAccessTypeGET:{
            request.requestFinishSuccessCompletion = requestFinishSuccessCompletion;
            request.requestFinishFailedCompletion = requestFinishFailedCompletion;
            request.requestFailedCompletion = requestFailedCompletion;
            [GNAPIClient executeGetRequest:request];
        }
            break;
        case GNAPIAccessTypePOST:{
            request.requestFinishSuccessCompletion = requestFinishSuccessCompletion;
            request.requestFinishFailedCompletion = requestFinishFailedCompletion;
            request.requestFailedCompletion = requestFailedCompletion;
            [GNAPIClient executePostRequest:request];
        }
            break;
        default:
            break;
    }
}

+ (void)execute:(GNAPIRequest *)request uploadProgress:(requestProgress)uploadProgress finishedSuccessedCompletion:(requestFinishSuccessCompletion)requestFinishSuccessCompletion finishedFailedCompletion:(requestFinishFailedCompletion)requestFinishFailedCompletion failedCompletion:(requestFailedCompletion)failedCompletion
{
    switch (request.accessType) {
        case GNAPIAccessTypeUpload:
        {
            request.requestProgress = uploadProgress;
            request.requestFinishSuccessCompletion = requestFinishSuccessCompletion;
            request.requestFinishFailedCompletion = requestFinishFailedCompletion;
            request.requestFailedCompletion = failedCompletion;
            
            [GNAPIClient executeUploadRequest:request];
        }
            break;
            
        default:
            break;
    }
}

+ (void)execute:(GNAPIRequest *)request downloadProgress:(requestProgress)downloadProgress downloadDestination:(requestDownloadDestination)downloadDestination downloadSuccessCompletion:(requestDownloadSuccessedCompletion)downloadSuccessCompletion downloadFailedCompletion:(requestDownloadFailedCompletion)downloadFailedCompletion
{
    switch (request.accessType) {
        case GNAPIAccessTypeDownload:
        {
            request.requestProgress = downloadProgress;
            request.downloadDestination = downloadDestination;
            request.downloadSuccessedCompletion = downloadSuccessCompletion;
            request.downloadFailedCompletion = downloadFailedCompletion;
            
            [GNAPIClient executeDownloadRequest:request];
        }
            break;
            
        default:
            break;
    }
}

+ (void)cancelRequest:(GNAPIRequest *)request
{
    if ([GNHttpSessionManager sharedManager]) {
        [[GNHttpSessionManager sharedManager].operationQueue cancelAllOperations];
        [[GNHttpSessionManager sharedManager] invalidateSessionCancelingTasks:YES resetSession:YES];
    }
}

+ (void)monitorNetworkReachabilityStatusChangeBlock:(GNNetworkReachabilityStatusChangeBlock)networkReachabilityStatusChangeBlock
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            if (networkReachabilityStatusChangeBlock) {
                networkReachabilityStatusChangeBlock(GNNetworkReachabilityStatusUnknown);
                GNLog(@"当前网络：未知网络");
            }
        } else if (status == AFNetworkReachabilityStatusNotReachable) {
            if (networkReachabilityStatusChangeBlock) {
                networkReachabilityStatusChangeBlock(GNNetworkReachabilityStatusNotReachable);
                GNLog(@"当前网络：没有网络");
            }
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            if (networkReachabilityStatusChangeBlock) {
                networkReachabilityStatusChangeBlock(GNNetworkReachabilityStatusReachableViaWWAN);
                GNLog(@"当前网络：手机流量");
            }
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            if (networkReachabilityStatusChangeBlock) {
                networkReachabilityStatusChangeBlock(GNNetworkReachabilityStatusReachableViaWiFi);
                GNLog(@"当前网络：WiFi");
            }
        }
    }];
}

+ (void)fetchNetworkReachabilityStatusBlock:(GNFetchNetworkReachabilityStatusBlock)networkReachabilityStatusBlock
{
    __block GNFetchNetworkReachabilityStatusBlock block_networkReachabilityStatusBlock = networkReachabilityStatusBlock;
    [self monitorNetworkReachabilityStatusChangeBlock:^(GNNetworkReachabilityStatus status) {
        if (block_networkReachabilityStatusBlock) {
            block_networkReachabilityStatusBlock(status);
            block_networkReachabilityStatusBlock = nil;
        }
    }];
}


#pragma mark public method

+ (void)executeGetRequest:(GNAPIRequest *)request {
    GNHttpSessionManager *manager = [GNHttpSessionManager sharedManager];
    manager.requestSerializer.timeoutInterval = request.timeout;
    
    [manager GET:request.fullUrl parameters:request.fullParams headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [request callbackRequestProgress:downloadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (request.fetchResponseHeader) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            request.responseHeaders = response.allHeaderFields;
        }
        [request callbackRequestFinishedWith:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [request callbackRequestFailedWith:error];
    }];
    
}

+ (void)executePostRequest:(GNAPIRequest *)request {
    GNHttpSessionManager *manager = [GNHttpSessionManager sharedManager];
    manager.requestSerializer.timeoutInterval = request.timeout;
    
    [manager POST:request.fullUrl parameters:request.fullParams headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        [request callbackRequestProgress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (request.fetchResponseHeader) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            request.responseHeaders = response.allHeaderFields;
        }
        [request callbackRequestFinishedWith:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [request callbackRequestFailedWith:error];
    }];
    
}

+ (void)executeUploadRequest:(GNAPIRequest *)request
{
    GNHttpSessionManager *manager = [GNHttpSessionManager sharedManager];
    manager.requestSerializer.timeoutInterval = request.timeout;
    
    [manager POST:request.fullUrl parameters:request.fullParams headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 上传图片
        if (request.uploadFileType == GNAPIUploadFileTypeImage) {
            if (request.uploadParam) {
                [request.uploadParam enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<UIImage *> * _Nonnull fileArray, BOOL * _Nonnull stop) {
                    [fileArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull uploadImage, NSUInteger idx, BOOL * _Nonnull stop) {
                        UIImage *image = (UIImage *)uploadImage;
                        NSData *imageData = [image compressedData];
                        //创建时间戳
                        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
                        NSTimeInterval time = [date timeIntervalSince1970] * 1000;// *1000 是精确到毫秒，不乘就是精确到秒
                        NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
                        NSString *imageName = [timeString stringByAppendingString:@".jpg"];
                        NSString *type = @"image/jpg/png/jpeg";
                        [formData appendPartWithFileData:imageData name:key fileName:imageName mimeType:type];
                    }];
                }];
            }
        }
        
        if (request.uploadFileType == GNAPIUploadFileTypeVideo) {
            // 上传视频
            if (request.uploadVideoParam) {
                NSString *key = request.uploadVideoParam.allKeys.firstObject;
                NSString *videoPath = request.uploadVideoParam.allValues.firstObject;
                NSString *fileName = videoPath.lastPathComponent;
                NSString *type = @"video/mp4/quicktime";
                if (videoPath.length) {
                    NSData *videoData = [NSData dataWithContentsOfFile:videoPath];
                    if (videoData) {
                        [formData appendPartWithFileData:videoData name:key fileName:fileName mimeType:type];
                    }
                }
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [request callbackRequestProgress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [request callbackRequestFinishedWith:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [request callbackRequestFailedWith:error];
    }];
}

/** 执行download网络请求 */
+ (void)executeDownloadRequest:(GNAPIRequest *)request
{
    GNHTTPDownloadSessionManager *manager = [GNHTTPDownloadSessionManager downloadManager];
    NSURL *url = [NSURL URLWithString:request.downloadUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        [request callbackRequestProgress:downloadProgress];
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [request callBackDownloadResponse:response destination:targetPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            [request callBackDownloadSuccessWithResponse:response toFilePath:filePath];
        } else {
            [request callBackDownloadFailedWithResponse:response toFilePath:filePath error:error];
        }
    }];
    
    [downloadTask resume];
}



@end


@implementation GNHttpSessionManager

static GNHttpSessionManager *_intstace = nil;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _intstace = [GNHttpSessionManager manager];
        _intstace.requestSerializer = [AFHTTPRequestSerializer serializer];
        _intstace.responseSerializer = [AFJSONResponseSerializer serializer];
        _intstace.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _intstace;
}

@end

@implementation GNHTTPDownloadSessionManager

static GNHTTPDownloadSessionManager *_downloadIntstace = nil;
+ (instancetype)downloadManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        NSString *identifier = [NSString stringWithFormat:@"%@.BackgroudSeesion", bundleId];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];
        configuration.timeoutIntervalForRequest = 180.f;
        configuration.allowsCellularAccess = YES;
        _downloadIntstace = [[GNHTTPDownloadSessionManager alloc] initWithBaseURL:nil sessionConfiguration:configuration];
        _downloadIntstace.requestSerializer = [AFHTTPRequestSerializer serializer];
        _downloadIntstace.responseSerializer = [AFJSONResponseSerializer serializer];
        _downloadIntstace.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _downloadIntstace;
}

@end
