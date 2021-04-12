//
//  GNHudTool.m
//  InstantTalk
//
//  Created by trueway on 2021/4/6.
//  Copyright © 2021 Kimi Hughes. All rights reserved.
//

#import "GNHudTool.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

@interface GNHudTool()
@property (nonatomic, strong) MBProgressHUD *hud;
@end
@implementation GNHudTool

GNSingletonM(GNHudTool,shareInstance)

//业务层可独立出来
+ (void)showXWGifHudInWindows {
    GNHudTool *tool = [GNHudTool shareInstance];
    [tool showGifProcessHudViewWithGifName:@"gifLoading" withContentSize:CGSizeMake(100,100) inView:nil animated:YES];
}



+ (void)hideHudInWindows {
    GNHudTool *tool = [GNHudTool shareInstance];
    [tool hideHudAnimated:YES];
}

- (void)showGifProcessHudViewWithGifName:( NSString *)gifName withContentSize:(CGSize)size inView:(nullable UIView *)view animated:(BOOL)animated {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    if (self.hud) return;
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor = [UIColor clearColor];
    self.hud.customView = [self _configGifViewWithGif:gifName withContentSize:size];
    self.hud.mode = MBProgressHUDModeCustomView;
}

- (void)hideHudAnimated:(BOOL)animated {
    [self.hud hideAnimated:animated];
    self.hud = nil;
}

- (UIView *)_configGifViewWithGif:(NSString *)gifName withContentSize:(CGSize)size {
    NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[gifName stringByAppendingString:@"@2x"] ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:retinaPath];
    UIImage *image = [UIImage sd_imageWithGIFData:data];
    GNGifImageView *gifImageView = [[GNGifImageView alloc] initWithContentSize:size];
    gifImageView.image = image;
    return gifImageView;
}

@end

@implementation GNGifImageView
- (instancetype)initWithContentSize:(CGSize)size {
    if (self = [super init]) {
        self.gifContentSize = size;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.gifContentSize = CGSizeMake(100, 100);
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = self.gifContentSize;
    return size;
}
@end

