//
//  GNHudTool.h
//  InstantTalk
//
//  Created by trueway on 2021/4/6.
//  Copyright © 2021 Kimi Hughes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNCore.h"

NS_ASSUME_NONNULL_BEGIN

@interface GNHudTool : NSObject

GNSingletonH(sharedInstance)

+ (void)showXWGifHudInWindows;

+ (void)hideHudInWindows;

- (void)showGifProcessHudViewWithGifName:(NSString *)gifName withContentSize:(CGSize)size inView:(nullable UIView *)view animated:(BOOL)animated;

- (void)hideHudAnimated:(BOOL)animated;
@end

@interface GNGifImageView : UIImageView
- (instancetype)initWithContentSize:(CGSize)size;
@property (nonatomic, assign) CGSize gifContentSize;
@end

NS_ASSUME_NONNULL_END
