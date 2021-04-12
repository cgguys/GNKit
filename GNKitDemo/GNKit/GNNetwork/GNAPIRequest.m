//
//  GNAPIRequset.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/8.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNAPIRequest.h"

@implementation GNAPIRequest

- (NSString *)baseUrl {
    return @"";
}

- (NSString *)fullUrl {
    NSString *fullUrl = [self.baseUrl stringByAppendingString:self.requestUrl];
    return fullUrl;
}

- (NSString *)requestUrl {
    return @"";
}

- (GNAPIAccessType)accessType {
    return GNAPIAccessTypeGET;
}

- (NSTimeInterval)timeout {
    return 20;
}

- (NSString *)pagesize {
    return @"20";
}

- (NSString *)page {
    return @"1";
}

- (NSDictionary<NSString *,NSString *> *)defultParams {
    return @{};
}

- (NSDictionary<NSString *,NSString *> *)params {
    return @{};
}

- (BOOL)fetchResponseHeader {
    return NO;
}

- (GNAPIUploadFileType)uploadFileType {
    return GNAPIUploadFileTypeImage;
}

- (NSDictionary<NSString *, NSArray<UIImage *> *> *)uploadParam
{
    return nil;
}
- (NSDictionary<NSString *, NSString *> *)uploadVideoParam
{
    return nil;
}

- (NSString *)downloadUrl
{
    return @"";
}

- (NSDictionary<NSString *,NSString *> *)fullParams {
    NSMutableDictionary *fullParams = [NSMutableDictionary dictionary];
    if (self.defultParams && self.defultParams.count>0) {
        [self.defultParams enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [fullParams setValue:obj forKey:key];
        }];
    }
    
    if (self.params && self.params.count>0) {
        [self.params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [fullParams setValue:obj forKey:key];
        }];
    }
    
    return fullParams.copy;
}

- (void)callbackRequestFinishedWith:(id)responseData {
    GNAPIResult *result = [[GNAPIResult alloc] initWithResponseData:responseData];
    if (result.success) {
        if (self.requestFinishSuccessCompletion) {
            self.requestFinishSuccessCompletion(self, result);
            self.requestFinishSuccessCompletion = nil;
        }
    }else {
        if (self.requestFinishFailedCompletion) {
            self.requestFinishFailedCompletion(self, result.message);
            self.requestFinishFailedCompletion = nil;
        }
    }
}

- (void)callbackRequestFailedWith:(NSError *)error {
    if (self.requestFailedCompletion){
        self.requestFailedCompletion(error);
        self.requestFailedCompletion = nil;
    }
}

- (void)callbackRequestProgress:(NSProgress *)progress {
    if (self.requestProgress) {
        self.requestProgress(self,progress);
        self.requestProgress = nil;
    }
}

// 处理下载路劲
- (NSURL *)callBackDownloadResponse:(NSURLResponse *)response destination:(NSURL *)targetPath
{
    if (self.downloadDestination) {
        return self.downloadDestination(self, response, targetPath);
    }
    return nil;
}
/**
 * 处理下载成功
 */
- (void)callBackDownloadSuccessWithResponse:(NSURLResponse *)response toFilePath:(NSURL *)filePath
{
    if (self.downloadSuccessedCompletion) {
        self.downloadSuccessedCompletion(self, response, filePath);
        self.downloadSuccessedCompletion = nil;
    }
}
/**
 * 处理下载失败
 */
- (void)callBackDownloadFailedWithResponse:(NSURLResponse *)response toFilePath:(NSURL *)filePath error:(NSError *)error
{
    
    if (self.downloadFailedCompletion) {
        self.downloadFailedCompletion(self, response, filePath, error);
        self.downloadFailedCompletion = nil;
    }
}


@end
