//
//  UIButton+GNKit.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/14.
//  Copyright © 2021 gunan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (GNKit)

- (void)setText:(nullable NSString *)text image:(nullable UIImage *)image highlightImage:(nullable UIImage *)highlightImage clickCallback:(void(^)(__kindof UIButton *button))callback;

@property(nonatomic, copy, nullable) void (^clickCallback)(__kindof UIButton *button);


@end

///构造button实例
CG_INLINE __kindof UIButton *
ButtonWithElementsAndClickAction(NSString * _Nullable text,UIImage * _Nullable image,UIImage * _Nullable highlightImage, void (^ _Nullable callback)(__kindof UIButton *button)) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setText:text image:image highlightImage:highlightImage clickCallback:callback];
    return button;
}

NS_ASSUME_NONNULL_END


