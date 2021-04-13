//
//  GNFloatingWindow.h
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickCallback)(void);

NS_ASSUME_NONNULL_BEGIN

@interface GNFloatingWindow : UIWindow
///悬浮按钮静止时图片
@property(nonatomic, strong) UIImage *staticImage;
///悬浮按钮拖动时图片
@property(nonatomic, strong) UIImage *dragingImage;
///点击事件回调
@property(nonatomic, copy, nullable) clickCallback clickCallback;

+ (GNFloatingWindow *)showFloatingViewWithFrame:(CGRect)frame Image:(nullable UIImage *)image dragingImage:(nullable UIImage *)dragingImage clickCallback:(clickCallback)clickCallback;

+ (GNFloatingWindow *)showSuperManWithpaunchBcak:(clickCallback)clickCallback;
@end

NS_ASSUME_NONNULL_END
