//
//  UIImage+GNKit.m
//  GNKitDemo
//
//  Created by trueway on 2021/4/9.
//  Copyright © 2021 gunan. All rights reserved.
//

#import "UIImage+GNKit.h"

@implementation UIImage (GNKit)

- (NSData *)compressedData
{
    NSData *imageData = UIImageJPEGRepresentation(self, 0.9);
    if (imageData && imageData.length) {
        return imageData;
    } else {
        return UIImagePNGRepresentation(self);
    }
}

@end
