//
//  ViewController.m
//  GNKitDemo
//
//  Created by Apple on 2021/3/25.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        GNLog(@"1");
    });
    
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    GNLog(@"全部结束");
    NSLog(@"%@",UIApplication.sharedApplication.delegate.window);
    
    
    UIButton *btn = ButtonWithElementsAndClickAction(@"aaa", nil, nil, nil);
    
}



@end
