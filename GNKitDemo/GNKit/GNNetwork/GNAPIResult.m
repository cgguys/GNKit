//
//  GNAPIResult.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/8.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNAPIResult.h"

@implementation GNAPIResult

- (instancetype)initWithResponseData:(id)responseData {
    if (self = [super init]) {
        if (responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                self.success = 1;
                NSDictionary *dic = (NSDictionary *)responseData;
                // 返回数据
                if ([[dic objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                    NSArray *data = [dic objectForKey:@"result"];
                    self.arrayData = data;
                }else
                
                if ([[dic objectForKey:@"result"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dictData = [dic objectForKey:@"result"];
                    self.dicData = dictData;
                }
            }else if ([responseData isKindOfClass:[NSArray class]]){
                self.success = 1;
                self.arrayData = (NSArray *)responseData;
            }else {
                self.success = 0;
                self.arrayData = nil;
                self.dicData = nil;
            }
        }else {
            self.success = 0;
        }
    }
    return self;
}

@end
