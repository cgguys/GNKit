//
//  UIButton+GNKit.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/14.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "UIButton+GNKit.h"

@implementation UIButton (GNKit)

- (void)setText:(nullable NSString *)text image:(nullable UIImage *)image highlightImage:(nullable UIImage *)highlightImage clickCallback:(void(^)(__kindof UIButton *button))callback {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highlightImage forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    self.clickCallback = callback;
}

- (void)clickAction{
    if (self.clickCallback) {
        self.clickCallback(self);
    }
}

static char kAssociatedObjectKey_clickCallback;
- (void)setClickCallback:(void(^)(UIButton *))clickCallback {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_clickCallback, clickCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void(^)(UIButton *))clickCallback {
    return (void(^)(UIButton *))objc_getAssociatedObject(self, &kAssociatedObjectKey_clickCallback);
}

@end
