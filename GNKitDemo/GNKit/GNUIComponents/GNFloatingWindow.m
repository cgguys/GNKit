//
//  GNFloatingWindow.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/13.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "GNFloatingWindow.h"
#define kFloatingViewHeight 50.f
#define kFloatingViewWidth 50.f

@interface GNFloatingWindow ()
@property(nonatomic, strong) QMUIButton *floatingButton;
@end
@implementation GNFloatingWindow

+ (GNFloatingWindow *)showSuperManWithpaunchBcak:(clickCallback)clickCallback {
    return [GNFloatingWindow showFloatingViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, kFloatingViewWidth, kFloatingViewHeight) Image:nil dragingImage:nil clickCallback:clickCallback];
}

+ (GNFloatingWindow *)showFloatingViewWithFrame:(CGRect)frame Image:(nullable UIImage *)image dragingImage:(nullable UIImage *)dragingImage clickCallback:(clickCallback)clickCallback {
    GNFloatingWindow *window = [[GNFloatingWindow alloc] initWithFrame:frame];
    window.staticImage = image;
    window.dragingImage = dragingImage;
    window.clickCallback = clickCallback;
    return window;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorClear;
        self.rootViewController = [[UIViewController alloc] init];
        self.windowLevel = UIWindowLevelStatusBar;
        self.floatingButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        self.floatingButton.frame = self.bounds;
        [self.floatingButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.rootViewController.view addSubview:self.floatingButton];
        [self.floatingButton setImage:GNImage(@"chaoren") forState:UIControlStateNormal];
        [self.floatingButton setImage:GNImage(@"chaoren") forState:UIControlStateHighlighted];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
        [pan addTarget:self action:@selector(dragFloatingView:)];
        [self.floatingButton addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - action

- (void)clickAction:(QMUIButton *)button {
    if (self.clickCallback) {
        self.clickCallback();
    }
}

- (void)dragFloatingView:(UIPanGestureRecognizer *)pan {
        
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
            {
                CGPoint movePath = [pan translationInView:self];
                [pan setTranslation:CGPointZero inView:self];
                self.center = CGPointMake(self.center.x + movePath.x, self.center.y + movePath.y);
            }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            {
                CGPoint movePath = [pan translationInView:self];
                [pan setTranslation:CGPointZero inView:self];
                CGPoint point = CGPointMake(self.center.x + movePath.x, self.center.y + movePath.y);
                CGFloat left = point.x;
                CGFloat top = point.y;
                CGFloat right = SCREEN_WIDTH - left;
                CGFloat bottom = SCREEN_HEIGHT - top;
                [UIView animateWithDuration:0.3 animations:^{
                    if ((left <= top && left <= bottom) || (right <= top && right <= bottom) ) {
                        if (left < right) {

                            self.center = CGPointMake(kFloatingViewWidth/2, top);
                        }else {
                            self.center = CGPointMake(SCREEN_WIDTH - kFloatingViewWidth/2, top);
                        }
                    }else {
                        if (top < bottom) {
                            self.center = CGPointMake(left, kFloatingViewHeight/2 + kScreenTopSafeArea);
                        }else {
                            self.center = CGPointMake(left, SCREEN_HEIGHT - kFloatingViewHeight/2 - kScreenBottomSafeArea);
                        }
                    }
                }];
            }
            break;
        default:
            break;
    }
}

- (void)setStaticImage:(UIImage *)staticImage {
    _staticImage = staticImage;
    if (_staticImage) {
        [self.floatingButton setImage:_staticImage forState:UIControlStateNormal];
    }
}

- (void)setDragingImage:(UIImage *)dragingImage {
    _dragingImage = dragingImage;
    if (_dragingImage) {
        [self.floatingButton setImage:_dragingImage forState:UIControlStateNormal];
    }}
@end
