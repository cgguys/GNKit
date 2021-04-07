//
//  NSTimer+WeakTimer.m
//  GNKitDemo
//
//  Created by Apple on 2021/3/25.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "NSTimer+WeakTimer.h"

@interface TimerWeakObject : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;

@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector withObject:self.timer.userInfo];
        }
    }else {
        [self.timer invalidate];
    }
}

@end

@implementation NSTimer (WeakTimer)

//利用中间对象弱引用NSTimer解除循环引用
+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    TimerWeakObject *weakObject = [[TimerWeakObject alloc] init];
    weakObject.target = aTarget;
    weakObject.selector = aSelector;
    weakObject.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:weakObject selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    return weakObject.timer;
}

@end
