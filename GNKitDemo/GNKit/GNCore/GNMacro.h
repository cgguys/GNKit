//
//  GNMacro.h
//  GNKitDemo
//
//  Created by Apple on 2021/3/29.
//  Copyright © 2021 gunan. All rights reserved.
//

#ifndef GNMacro_h
#define GNMacro_h

//弱引用
//#define @weakify __weak typeof(self) weakSelf = self;

#define GNIsString(string) [string isKindOfClass:[NSString class]]

#define GNLog(s)  QMUILog(nil,s)
#define GNLogInfo(s) QMUILogInfo(nil,s)
#define GNLogWarn(s) QMUILogWarn(nil,s)

#pragma mark - 完整的ARC单例宏
// .h文件
#define GNSingletonH(functionName) + (instancetype)functionName;
// .m文件
#define GNSingletonM(className, functionName) \
static className *_instance = nil;\
+ (instancetype)functionName\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[super allocWithZone:NULL] init];\
});\
return _instance;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
return [self functionName];\
}\
\
- (id)copy\
{\
return [self.class functionName];\
}\
\
- (id)mutableCopy\
{\
return [self.class functionName];\
}


#endif /* GNMacro_h */
