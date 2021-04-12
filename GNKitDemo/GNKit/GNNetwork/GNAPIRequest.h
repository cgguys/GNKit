//
//  GNAPIRequset.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/8.
//  Copyright © 2021 gunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNAPIResult.h"

@class GNAPIRequest;

typedef NS_ENUM(NSInteger, GNAPIAccessType) {
    GNAPIAccessTypeGET,
    GNAPIAccessTypePOST,
    GNAPIAccessTypeUpload,
    GNAPIAccessTypeDownload
};

typedef NS_ENUM(NSUInteger, GNAPIUploadFileType) {
    GNAPIUploadFileTypeImage,          // 图片
    GNAPIUploadFileTypeVideo,          // 视频
    GNAPIUploadFileTypeAudio,          // 音频
    GNAPIUploadFileTypeOther,          // 其他
};

NS_ASSUME_NONNULL_BEGIN

typedef void (^requestFinishSuccessCompletion)(GNAPIRequest *request, GNAPIResult *result);

typedef void (^requestFinishFailedCompletion)(GNAPIRequest *request, NSString *message);

typedef void (^requestFailedCompletion)(NSError *error);

typedef void (^requestProgress)(GNAPIRequest *request, NSProgress *progress);

typedef NSURL * _Nonnull (^requestDownloadDestination)(GNAPIRequest *request, NSURLResponse *response, NSURL *targetPath);

typedef void (^requestDownloadSuccessedCompletion)(GNAPIRequest *request, NSURLResponse *response, NSURL *filePath);

typedef void (^requestDownloadFailedCompletion)(GNAPIRequest *request, NSURLResponse *response, NSURL * _Nullable filePath, NSError *error);

@interface GNAPIRequest : NSObject

@property(nonatomic, assign, readonly) GNAPIAccessType accessType;

@property(nonatomic, copy, readonly) NSString *fullUrl;

@property(nonatomic, copy, readonly) NSString *baseUrl;

@property(nonatomic, copy, readonly) NSString *requestUrl;

@property(nonatomic, copy, readonly) NSString *pagesize;

@property(nonatomic, copy, readonly) NSString *page;

@property(nonatomic, copy, readonly) NSDictionary<NSString*, NSString*> *defultParams;

@property(nonatomic, copy, readonly) NSDictionary<NSString*, NSString*> *params;

@property(nonatomic, copy, readonly) NSDictionary<NSString*, NSString*> *fullParams;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSArray<UIImage *> *> *uploadParam;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *uploadVideoParam;

@property(nonatomic, assign, readonly) GNAPIUploadFileType uploadFileType;

@property (nonatomic, copy, readonly) NSString *downloadUrl;

@property(nonatomic, assign, readonly) NSTimeInterval timeout;

@property (nonatomic, assign, readonly) BOOL fetchResponseHeader;

@property(nonatomic, copy, nullable) NSDictionary *responseHeaders;

//blcok回调

@property(nonatomic, copy, nullable) requestFinishSuccessCompletion requestFinishSuccessCompletion;

@property(nonatomic, copy, nullable) requestFinishFailedCompletion requestFinishFailedCompletion;

@property(nonatomic, copy, nullable) requestFailedCompletion requestFailedCompletion;

@property(nonatomic, copy, nullable) requestProgress requestProgress;

@property (nonatomic, copy, nullable) requestDownloadDestination downloadDestination;
/** 下载成功信息回调 */
@property (nonatomic, copy, nullable) requestDownloadSuccessedCompletion downloadSuccessedCompletion;
/** 下载失败信息回调 */
@property (nonatomic, copy, nullable) requestDownloadFailedCompletion downloadFailedCompletion;


- (void)callbackRequestFinishedWith:(id)responseData;

- (void)callbackRequestFailedWith:(NSError *)error;

- (void)callbackRequestProgress:(NSProgress *)progress;

/**
 * 处理下载路径
 * @param response 服务器返回的回应
 * @param targetPath 下载的路径
 * @return 下载的路径url
 */
- (NSURL *)callBackDownloadResponse:(NSURLResponse *)response destination:(NSURL *)targetPath;
/**
 * 处理下载成功
 * @param response 服务器返回的回应
 * @param filePath 下载成功的路径
 */
- (void)callBackDownloadSuccessWithResponse:(NSURLResponse *)response toFilePath:(NSURL *)filePath;
/**
 * 处理下载失败
 * @param response 服务器返回的回应
 * @param filePath 下载成功的路径
 * @param error 失败的信息
 */
- (void)callBackDownloadFailedWithResponse:(NSURLResponse *)response toFilePath:(NSURL *)filePath error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
