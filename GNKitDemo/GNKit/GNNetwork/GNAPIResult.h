//
//  GNAPIResult.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/8.
//  Copyright © 2021 gunan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GNAPIResult : NSObject

@property(nonatomic, copy) NSString *message;

@property(nonatomic, assign) BOOL success;

@property(nonatomic, copy) NSDictionary * _Nullable dicData;

@property(nonatomic, copy) NSArray * _Nullable arrayData;

@property(nonatomic, copy) id responseData;

- (instancetype)initWithResponseData:(id)responseData;

@end

NS_ASSUME_NONNULL_END
